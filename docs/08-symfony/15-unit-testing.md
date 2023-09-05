# _Testing_ en Symfony

## Introducció

Symfony inclou una recepta que integra en el framework diferents ferramentes
per a realitzar proves tant per a proves unitàries (PHPUnit) com per a proves
d'integració i proves funcionals, com Panther i DOM crawler.

La secció [Test](https://symfony.com/doc/current/testing.html) de la documentació de Symfony
és un bon lloc per on començar.

En aquesta secció parlarem dels tests funcionals. L'objectiu és crear dos tests: un 
per comprovar que el control d'accés funciona com s'espera i l'altre per provar un 
formulari.

## _Testing_ del control d'accés


### Pas 1: Creació del test
```sh
php bin/console make:test

 Which test type would you like?:
  [TestCase       ] basic PHPUnit tests
  [KernelTestCase ] basic tests that have access to Symfony services
  [WebTestCase    ] to run browser-like scenarios, but that don't execute JavaScript code
  [ApiTestCase    ] to run API-oriented scenarios
  [PantherTestCase] to run e2e scenarios, using a real-browser or HTTP client and a real web server


Choose a class name for your test, like:
 * UtilTest (to create tests/UtilTest.php)
 * Service\UtilTest (to create tests/Service/UtilTest.php)
 * \App\Tests\Service\UtilTest (to create tests/Service/UtilTest.php)

 The name of the test class (e.g. BlogPostTest):
 > AccessControlTest

 created: tests/AccessControlTest.php

           
  Success! 
           

 Next: Open your new test class and start customizing it.
 Find the documentation at https://symfony.com/doc/current/testing.html#functional-tests
```

Codi que ens genera és el següent:

```php
class AccessControlTest extends WebTestCase
{
    public function testSomething(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/');

        $this->assertResponseIsSuccessful();
        $this->assertSelectorTextContains('h1', 'Hello World');
    }
}
```

En resum el que fa és crear un client HTTP i sol·licitar la pàgina principal.
Després espera que la resposta siga correcta (200) i el text resultant continga
un `h1` amb el text `Hello World`.


En el següent mètode comprovem en accedir a l'URL que ens permet
crear un nou Tweet amb un usuari anònim la resposta ha de ser una redirecció (a la 
pàgina d'inici de sessió).

```php
    public function testAnonymousCannotComposeTweets(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/compose/tweet');

      
        // En aquest cas comprovem que si un usuari anònim intenta accedir ha de redirigir-lo
        // a la pàgina d'inici de sessió
        $this->assertResponseStatusCodeSame(Response::HTTP_FOUND);
      
    }
```

### Pas 2: Proves amb usuaris autenticats

Gràcies al mètode `BrowserKit::loginUser` és molt senzill simular l'inici de 
sessió d'un usuari. Això sí, caldrà carregar-lo prèviament del repositori.

En el següent mètode emprarem un usuari autenticat per fer la mateixa sol·licitud
esperant un codi d'estat OK. Per poder carregar l'usuari cal configurar una 
base de dades de proves.


```php
public function testAuthenticatedUsersCanComposeTweets(): void
{
  $client = static::createClient();
  $userRepository = static::getContainer()->get(UserRepository::class);

        // retrieve the test user
        $testUser = $userRepository->findOneByUsername('user');

        $client->loginUser($testUser);

        $crawler = $client->request('GET', '/compose/tweet');
        
        // En aquest cas comprovem que si un usuari autenticat intenta accedir retornarà un estat 200.
        $this->assertResponseStatusCodeSame(Response::HTTP_OK);        
}
```

!!! info "Entorn de proves"
    Per poder generar una base de dades de prova caldrà configurar la connexió a l'entorn `.env.test`. I després
    es poden usar els comandaments de la consola amb el paràmetre `--env=test`. Per seguretat, a la base de dades de prova 
    se li afegirà el prefix `_test`.

### Pas 3: Ús d'un proveidor de dades.

Un proveïdor de dades en PHPUnit és un mètode que proporciona dades de prova per a un test. Es pot utilitzar per a provar la mateixa funció o mètode amb diferents entrades de dades. El mètode del proveïdor de dades es marca amb l'anotació "@dataProvider".

En els nostres tests podríem implementar-ho així:


```php
    /**
     * @return void
     * @dataProvider getUrlsForAnonymousUsers
     */
    public function testAnonymousAccessControl(string $url, int $status, string $method = 'GET'): void
    {
        $client = static::createClient();
        $crawler = $client->request($method, $url);

        $this->assertResponseStatusCodeSame($status);
    }
    public function getUrlsForAnonymousUsers(): iterable
    {
        yield ["/", Response::HTTP_FOUND];
        yield ["/login", Response::HTTP_OK];
        yield ["/invalid-route", Response::HTTP_NOT_FOUND];
        yield ["/register", Response::HTTP_OK];
        yield ["/logout", Response::HTTP_FOUND];
        yield ["/compose/tweet", Response::HTTP_FOUND];
        yield ["/home", Response::HTTP_OK];
        yield ["/user", Response::HTTP_OK];
        yield ["/tweets/12/like", Response::HTTP_FOUND];
    }
```

!!! info "yield"
    `yield` s'utilitza dins d'una funció generadora per retornar un valor i posar en pausa l'execució fins que es demani el següent valor. Això permet generar i retornar una seqüència de valors un a la vegada, en lloc de tots alhora com en les funcions regulars. Això proporciona una manera d'escriure codi més eficient i amable amb la memòria, ja que només es generen valors segons es necessiten, en lloc de generar tots els valors alhora.

