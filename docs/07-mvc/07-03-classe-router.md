# Rutes i controladors
Una de les tasques que ha de realitzar el nostre controlador frontal és enrutar, és a dir, analitzar la sol·licitud
de l'usuari i activar el controlador associat. Actualment el nostre "router" és molt bàsic i simplement fa una inclusió
de la pàgina que volem activar.

Una ruta estarà vinculada a un URL que ens donarà accés a un controlador.  És important, a l'hora de definir les rutes
seguir una convenció, nosaltres seguirem aquesta: [REST resource naming](https://restfulapi.net/resource-naming/). 

Així doncs, el _router_ s'ha d'encarregar de:

   1. Gestionar la taula de rutes, on es vincula cada ruta a un controlador.
   2. Resoldre les sol·licituds, és a dir, buscar el controlador vinculat a la ruta.

## El _router_

Per a disposar d'un component d'enrutament farem ús del component `Routing` de Symfony.

```php
composer require symfony\routing
```

Aquest component ens permetrà definir les rutes de la nostra aplicació:

```php
// routes.php
use Symfony\Component\Routing;
$routes = new Routing\RouteCollection();

$routes->add('index', new Routing\Route('/'));
$routes->add('login', new Routing\Route('/login'));

return $routes;
```

El primer paràmetre és el nom que li volem donar a la ruta, aquest nom ha de ser
únic. El segon paràmetre és un objecte de tipus [`Route`](https://github.com/symfony/routing/blob/6.2/Route.php).  


Les dues primeres rutes simplement defineixen dos URL vàlids de la
nostra aplicació. 



!!! info "`return` en fitxers"
    Fent `return $routes;`  en el fitxer que serà inclòs aconseguim un comportament
    semblant al de les funcions, com veurem a continuació.

El controlador frontal quedaria així: 


```php hl_lines="16-17"
// public/index.php
require_once __DIR__.'/../bootstrap.php';

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing;

$request = Request::createFromGlobals();
$routes = include __DIR__.'/../routes.php';

$context = new Routing\RequestContext();
$context->fromRequest($request);
$matcher = new Routing\Matcher\UrlMatcher($routes, $context);

try {
    extract($matcher->match($request->getPathInfo()), EXTR_SKIP);
    include sprintf(__DIR__.'/../%s.php', $_route);
} catch (Routing\Exception\ResourceNotFoundException $exception) {
    $response = new Response('Not Found', 404);
} catch (Exception $exception) {
    $response = new Response('An error occurred', 500);
}

$response->send();
```

Serà el mètode `match` de la classe `UrlMatcher` el que s'encarregarà de 
buscar el controlador associat a l'URL sol·licitat. 

En usar com a nom de la ruta el nom del fitxer sense `.php` ens permet fer la inclusió
usant el nom.

A més, incloure la funcionalitat dintre d'un bloc `try...catch` ens 
permetrà poder gestionar les excepcions globalment a l'aplicació.

## Els controladors

Com hem vist en la introducció, el controlador és el component del patró MVC que s'encarrega de rebre
la sol·licitud de l'usuari, interactuar en el model i la vista i retornar la informació al client. 

Els controladors solen implementar-se en una classe (ara els tenim en fitxers), els mètodes de la qual, 
són les diferents accions que es poden realitzar. 

Per exemple:

```php
namespace App\Controller;

...
class DefaultController
{

    public function index(Request $request): Response
    {
        $logger = Registry::get("logger");
        $tweetRepository = Registry::get(TweetRepository::class);
        $tweets = $tweetRepository->findAll();

        $logger->info("S'ha consultat la pagina", $tweets);

        $content = View::render('index', 'default', compact('tweets'));
        return new Response($content);
    }

}
```

Per poder activar els controladors caldrà introduir els següents canvis en la definició 
de rutes:


```php
// src/routes.php

use Symfony\Component\Routing;

$routes = new Routing\RouteCollection();
$routes->add('index', new Routing\Route('/',
    ['_controller'=>'App\Controller\DefaultController::index']));

$routes->add('login', 
    new Routing\Route(
        path: '/login',
        defaults: ['_controller'=>'App\Controller\DefaultController::login'], 
        methods: ["GET"])
    );

$routes->add('login_process',
    new Routing\Route(
        path:'/login',
        defaults: ['_controller'=>'App\Controller\DefaultController::loginProcess'],
        methods: ["POST"])
    );

return $routes;
```

Per a definir els controladors associats a cada URL usarem el segon paràmetre (`defaults`) del
constructor de `Route`, associant la clau `_controller`  al controlador. A més, també 
podem restringir les rutes a mètodes concrets. En aquest cas l'URL `/login` activarà un controlador 
diferent si la sol·licitud és `POST` o `GET`.

!!! alert "Parametres amb nom"
    Recorda que a partir de PHP 8.0 podem passar els paràmetres pel seu nom.


El nostre controlador frontal quedarà així:

```php hl_lines="12 13 16 18 19 21"
require_once __DIR__ . '/../bootstrap.php';

//...

$request = Request::createFromGlobals();
$routes = include __DIR__.'/../routes.php';

$context = new Routing\RequestContext();
$context->fromRequest($request);
$matcher = new Routing\Matcher\UrlMatcher($routes, $context);

$controllerResolver = new ControllerResolver();
$argumentResolver = new ArgumentResolver();

try {
    $request->attributes->add($matcher->match($request->getPathInfo()));

    $controller = $controllerResolver->getController($request);
    $arguments = $argumentResolver->getArguments($request, $controller);

    $response = call_user_func_array($controller, $arguments);
} catch (Routing\Exception\ResourceNotFoundException $exception) {
    $response = new Response('Not Found', 404);
} catch (Exception $exception) {
    $response = new Response('An error occurred: ' . $exception->getMessage(), 500);
}

$response->send();
```

Les classes `ControllerResolver` i `ArgumentResolver` s'encarreguen d'esbrinar, 
a partir de la sol·licitud, el controlador i els seus arguments, respectivament.

Formen part del component `http-kernel`  de Symfony que caldrà instal·lar:

```shell
composer require symfony/http-kernel
```

La funció `call_user_func_array` executa el controlador amb els seus arguments.

!!! important "Reflection (o reflexió)"
    La reflexió és quan un objecte és capaç d'examinar-se de forma retrospectiva per informar 
    dels seus mètodes, propietats o classes durant l'execució del script.



