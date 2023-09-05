# Doctrine Fixtures Bundle

Els _fixtures_ s'utilitzen per carregar un conjunt de dades "fals" en una base de dades que després es pot utilitzar per provar o per ajudar-vos a donar-vos dades interessants mentre desenvolupeu la vostra aplicació.

Aquest paquet és compatible amb qualsevol base de dades suportada per Doctrine ORM (MySQL, PostgreSQL, SQLite, etc.). 


## Instal·lació

```shell
composer require --dev orm-fixtures
```

## Escriure _Fixtures_

```php
// src/DataFixtures/AppFixtures.php
namespace App\DataFixtures;

use App\Entity\Movie;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        // create 20 movies! Bam!
        for ($i = 0; $i < 20; $i++) {
            $movie = new Movie();
            $movie->setTitle('Movie '.$i);
            $movie->setReleaseDate(new \DateTime());
            ....
    
            $manager->persist($movie);
        }

        $manager->flush();
    }
}
```

## _Fixtures_ que accedeixen a serveis

En alguns casos és possible que hàgeu d'accedir als serveis de la vostra aplicació dins d'un _fixture_. Cap problema! La teua classe és un servei, així que pots utilitzar la injecció normal de dependència:

```php
// src/DataFixtures/AppFixtures.php
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AppFixtures extends Fixture
{
    private UserPasswordHasherInterface $hasher;

    public function __construct(UserPasswordHasherInterface $hasher)
    {
        $this->hasher = $hasher;
    }

    // ...
    public function load(ObjectManager $manager)
    {
        // Usuari amb rol d'administrador
        $user = new User();
        $user->setUsername('admin');

        $password = $this->hasher->hashPassword($user, 'admin');
        $user->setPassword($password);
        $user->setRole("ROLE_ADMIN");

        $manager->persist($user);

        // Usuari amb rol d'usuari
        $user = new User();
        $user->setUsername('user');

        $password = $this->hasher->hashPassword($user, 'user');
        $user->setPassword($password);
        $user->setRole("ROLE_USER");
        
        $manager->persist($user);

        // apliquem els canvis a la base de dades
        $manager->flush();
    }
}
```

En aquest cas hem injectat la classe `UserPasswordHasherInterface` per
poder aplicar una funció-resum (_hash_) a les contrasenyes abans d'emmagatzemar-les.

## Carregant les _Fixtures_

```shell
php bin/console doctrine:fixtures:load
```

!!! danger 
    Per defecte l'ordre `load` esborra les dades de totes les taules. Per afegir les dades afig l'opció `--append`.

Més informació en [DoctrineFixturesBundle](https://symfony.com/bundles/DoctrineFixturesBundle/current/index.html) en la documentació oficial de Symfony.

## FakerPHP/Faker

Faker és una biblioteca PHP que genera dades falses per a tu. Tant si necessiteu arrancar la vostra base de dades, crear documents XML atractius, omplir la vostra capa de persistència per provar-la d'estrès o anonimitzar les dades extretes d'un servei de producció, Faker és per a vosaltres.

### Instal·lació

```php
composer require fakerphp/faker --dev
```

!!! info 
    Recorda que usem el paràmetre `--dev` per a aquells components que necessitem
    únicament en l'entorn de desenvolupament.

### Ús

```php hl_lines="31 39-42"
# src/DataFixtures/AppFixtures.php

namespace App\DataFixtures;
...
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
use Faker\Generator;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AppFixtures extends Fixture
{
    private UserPasswordHasherInterface $hasher;
    private Generator $faker;

    public function __construct(UserPasswordHasherInterface $hasher)
    {
        $this->hasher = $hasher;
        $this->faker = Factory::create();
    }

    ...

    public function load(ObjectManager $manager): void
    {
        //guarde en un array  els gèneres per després poder-los assignar a les pel·lícules.
        $genres = [];

        // Géneres
        for ($i=0; $i<4; $i++ ) {
            $genre = new Genre();
            $genre->setName($this->faker->word());
            $manager->persist($genre);
            $genres[] = $genre;
        }
        $manager->flush();

        for ($i=0; $i<14; $i++ ) {
            $movie = new Movie();
            $movie->setTitle(ucwords($this->faker->words(3, true)));
            $movie->setOverview($this->faker->text(500));
            $movie->setReleaseDate($this->faker->dateTime);
            $movie->setPoster($this->faker->file('assets', 'public/images', false));
            $movie->setGenre($genres[\array_rand($genres)]);
            $manager->persist($movie);
        }
        $manager->flush();
    ...
  }
}
```

En el codi anterior hi ha diversos exemples d'ús, del context es pot extreure la seua funcionalitat. En
la [documentació ofical de Faker](https://fakerphp.github.io/) trobareu més informació.