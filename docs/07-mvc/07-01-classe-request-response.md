# Request i Response

Altres classes que solen trobar-se en les _frameworks_ MVC són les classes `Request` i `Response`.
El seu objectiu és encapsular les funcionalitats relacionades amb la sol·licitud de l'usuari i
la resposta.

Nosaltres farem ús de les classes que ens proporciona el component `symfony/http-foundation`:

```console
composer require symfony/http-foundation
```

Ja tenim disponibles les classes:

```php
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

$request = Request::createFromGlobals();

$name = $request->query->get('name', 'World');

$response = new Response(sprintf('Hello %s', htmlspecialchars($name, ENT_QUOTES, 'UTF-8')));

$response->send();
```

El mètode `createFromGlobals()` crea un objecte `Request` basat en les variables supergoblals de PHP.

El mètode `send()` envia l'objecte `Response` al client.

Amb la classe `Request`, teniu tota la informació de l’aplicació al vostre abast gràcies a una API agradable i senzilla:

```php
// the URI being requested (e.g. /about) minus any query parameters
$request->getPathInfo();

// retrieves GET and POST variables respectively
$request->query->get('foo');
$request->request->get('bar', 'default value if bar does not exist');

// retrieves SERVER variables
$request->server->get('HTTP_HOST');

// retrieves an instance of UploadedFile identified by foo
$request->files->get('foo');

// retrieves a COOKIE value
$request->cookies->get('PHPSESSID');

// retrieves a HTTP request header, with normalized, lowercase keys
$request->headers->get('host');
$request->headers->get('content-type');

$request->getMethod();    // GET, POST, PUT, DELETE, HEAD
$request->getLanguages(); // an array of languages the client accepts
```

Amb la classe `Response` podeu ajustar la resposta:

```php
$response = new Response();

$response->setContent('Hello world!');
$response->setStatusCode(200);
$response->headers->set('Content-Type', 'text/html');

// configure the HTTP cache headers
$response->setMaxAge(10);
```

## Aplicació pràctica

Així quedaria la nova versió de les pàgines relacionades amb la creació de 
nous tuits.

En `tweet-new.php` faríem els següents canvis:

```php
## tweet-new.php

$request = Request::createFromGlobals();

// creem la resposta
$response = new Response();

// activem el buffering, l'eixida s'emmagatzema en memòria (buffer).
ob_start();
require 'views/tweet-new.view.php';
$content = ob_get_clean();
// la variable $content contindrà tot l'HTML generat per la vista.

$response->setContent($content);

$response->setStatusCode(200);
$response->headers->set('Content-Type', 'text/html');

// el mètode prepare assegura que la resposta compleix l'especificació HTTP.
$response->prepare($request);

$response->send();
```

Cal destacar:

- Les funcions `ob_start()` i `ob_get_clean()`. El primer activa el _buffering_, és a dir, canvia l'eixida 
    estàndard a memòria (_buffer_) i el segon retorna les dades del _buffer_, l'esborra i desactiva 
    el _buffering_. 
- El mètode `Response::prepare` s'assegura que la resposta acompleix l'especificació HTTP.


Els canvis en `tweet-new-process.php` serien aquests:

```php
...
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;


// comprovant si l'usuari ha iniciat sessió
$user = $_SESSION["user"] ?? null;

if (empty($user)) {
    $response = new RedirectResponse('login.php');
    $response->send();
}

$request = Request::createFromGlobals();

...

$newFilename = "";
$text = $request->request->get('text', '');
$text = filter_var($text, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

...

if (!empty($errors)) {
    FlashMessage::set('errors', $errors);
    FlashMessage::set('data', $data);
    $response = new RedirectResponse("tweet-new.php");
    $response->send();
}
try {

    $tweet = new Tweet($data["text"], $user);
    $tweet->setCreatedAt(new DateTime());
    $tweet->setLikeCount(0);

    $tweetRepository->save($tweet);

    if (!empty($newFilename)) {
        try {
            list($width, $height) = getimagesize(UPLOAD_PATH . "/" . $newFilename);
            $photo = new Photo($newFilename, $width, $height, $newFilename);
            $photo->setUrl($newFilename);
            $photo->setTweet($tweet);
            $tweet->addAttachment($photo);
            $photoRepository->save($photo);
        } catch (Exception $e) {
            $errors[] = $e->getMessage();
        }
    }
} catch (PDOException $e) {
    $errors[] = $e->getMessage();
}

if (!empty($errors)) {
    FlashMessage::set("errors", $errors);
    $response = new RedirectResponse("tweet-new.php");
    $response->send();
}

$_SESSION["data"] = $data;
$response = new RedirectResponse("index.php");
$response->send();
```

Resumint:

- Usarem la classe `RedirectResponse` per fer les redireccions.
- Emprarem `request->request->get('text', '')`, per a obtenir el que s'envia pel mètode POST. El segon paràmetre indica
    el valor que es tornarà en cas que no existisca dita variable.



## Encapsulant les vistes

Un altre aspecte que ens queda per convertir en classe és la gestió de les vistes. 
En lloc d'usar una inclusió farem ús de la següent classe que, a més d'encapsular 
la funcionalitat també incorpora l'opció d'usar plantilles:

```php
namespace App\Core;

class View
{
    static public function render(string $view, string $layout = 'default', 
        array $data = []): string {

        extract($data);

        ob_start();
        require __DIR__ . "/../../views/{$view}.view.php";
        $content = ob_get_clean();


        ob_start();
        require __DIR__ . "/../../views/layouts/{$layout}.layout.php";
        // Retorna el contingut del buffer i desactiva el buffering
        $content = ob_get_clean();

        return $content;
    }
}
```

!!! important "La constant màgica `__DIR__`"

    En PHP, generalment es considera una bona pràctica utilitzar la constant màgica `__DIR__`
    en lloc d'una ruta relativa quan s'inclouen o requereixen fitxers. Això es deu 
    al fet que `__DIR__` sempre retorna la ruta absoluta al directori on es troba el 
    fitxer on s'utilitza, mentre que un camí relatiu es pot veure afectat per la 
    ubicació de l'_script_ que l'està executant. 

Es pot observar l'ús de dues inclusions, la primera obté la informació de la 
vista que és passada a la plantilla mitjançant la variable `$content`.

La vista representa la part de la pàgina que canvia en cada pàgina, mentre
que la plantilla defineix aquells elements fixos de la pàgina.

Respecte a la funció `extract`, el que fa és convertir una _array_ associatiu en variables, 
on cada clau es converteix en una variable.

La seua contrapart és el mètode `compact` que converteix variables en un _array_ associatiu on
el nom de la variable és la clau i el seu valor, el valor.

Per exemple:

```php
$tweets = $tweetRepository->findAll();
echo View::render('index', 'default', compact('tweets'));
```

## Integrant la vista en la resposta

Per a integrar la vista en la resposta sols caldrà fer el següent:

```php
$content = View::render('index', 'default', compact('tweets'));
$response = new Response($content);
$response->send();
```

El contingut que retorna la vista el passem directament a la resposta pel constructor.

## Bibliografia i recursos

- <cite>The HttpFoundation Component (Symfony Docs)</cite>. <https://symfony.com/doc/current/create_framework/http_foundation.html>. Consulta 6 desembre 2022.

