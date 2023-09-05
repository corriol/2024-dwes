# Extrendre els repositoris. Paginació

## Introducció
Com ja has vist, l'objecte `Repository` permet executar consultes senzilles sense pràcticament cap treball:

```php
// from inside a controller
$repository = $em->getRepository(Link::class);
$movies = $repository->findAll();
```
Els mètodes disponibles són els següents:
 
```php
/**
 * @method Movie|null find($id, $lockMode = null, $lockVersion = null)
 * @method Movie|null findOneBy(array $criteria, array $orderBy = null)
 * @method Movie[]    findAll()
 * @method Movie[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
```

Però, i si necessitem una consulta més complexa? Quan generem una entitat amb `make:entity`, 
el comandament també genera una classe anomenada `MovieRepository`.

```php
# src/Repository/MovieRepository.php
namespace App\Repository;

use App\Entity\Movie;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class MovieRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Movie::class);
    }
   //...
}

```
Quan obtens el repositori (p.e. `->getRepository(Movie::class)`), estàs obtenint realment una instància d'aquest objecte!

!!! important "Anotacions"
    Cal assegurar-se que l'entitat té correctament vinculat el repositori mitjançant una anotació. En el nostre exemple l'entitat `Movie` haurà d'incloure:

    ```php
    @ORM\Entity(repositoryClass="App\Repository\MovieRepository")
    ```


### QueryBuilder 
Suposem que vols fer una consulta que obtinga totes les pel·lícules amb data posterior a certa data. Podríes afegir un nou mètode dins del repositori:

```php
// src/Repository/MovieRepository.php

// ...
class MovieRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Product::class);
    }

    /**
     * @return Movie[]
     */
    public function findAllAfterDate(DateTime $date): array{
        $query = $this->createQueryBuilder('m')
            ->andwhere("m.releaseDate >= :date")
            ->orderBy('l.releaseDate', 'DESC')
            ->setParameter('date', $date)
            ->getQuery();

        return $query->getResult();
    }

```

!!! info "Query Builder"
    *Query Builder*, és una forma orientada a objectes d'escriure consultes. Es recomana utilitzar-la quan les consultes es creen dinàmicament.


Ara, pots cridar el mètode del repositori:

```php
// from inside a controller
$date = new DateTime("2020-01-01");

$movies = $em
    ->getRepository(Movie::class)
    ->findAllAfterDate($date);

// ...
```

### Query 

També és possible utilitzar l'objecte `Query`, així com executar consultes directament amb PDO.

```php
   /**
     * @return Movie[]
     */
    public function findAllAfterDate(DateTime $date): array{
        $query = $this->createQuery('
            SELECT m
            FROM App\Entity\Movie m
            WHERE m.releaseDate >= :date
            ORDER BY m.releaseDate DESC')
            ->setParameter('date', $date);


        return $query->getResult();
    }
```

### Consultes SQL 

Aquest tipus de consultes s'executen directament en PDO, fent ús de les
classes `PDO`, `PDOStatement`.

```php
// src/Repository/MovieRepository.php

// ...
public function findAllAfterDate(DateTime $date): array
{
    // TODO: Revisar com accedir a la connexió
    $conn = $this->getEntityManager()->getConnection();

    $sql = '
        SELECT * FROM movie m
        WHERE m.release_date > :date
        ORDER BY m.release_date DESC
        ';
    $stmt = $conn->prepare($sql);
    $stmt->execute(['date' => $date]);

    // returns an array of arrays (i.e. a raw data set)
    return $stmt->fetchAll();
}
```
Aquestes consultes SQL tornen arrays, no objectes (a no ser que uses la funcionalitat [NativeQuery](https://www.doctrine-project.org/projects/doctrine-orm/en/latest/reference/native-sql.html)).

Més informació en [Querying for objects the repository](https://symfony.com/doc/current/doctrine.html#querying-for-objects-the-repository)

## Exemple
En el següent exemple pots observar un ús del nou mètode del repositori. Hem modificat la ruta `homepage` perquè comprove si ha rebut pel _querystring_ el paràmetre `start-date` si és així executarà el mètode `findAllAfterDate()`si no cridarà `findAll()`.

```php
    /**
     * @Route("/", name="homepage")
     */
    public function index(Request $request)
    {
        $repo = $this->getDoctrine()
            ->getRepository(Link::class);

        if ($request->query->has("start-date")) {
            $date = new \DateTime($request->query->get("start-date"));
            $links = $repo->findAllAfterDate($date);
            // TODO: check if the paràmeter start-date is a valid date

        }
        else {
            $links = $repo->findAll();
        }
        // now pass the array of default object to the view

        return $this->render('default/index.html.twig', [
            'links' => $links,
        ]);

    }
```

## Paginació

Symfony no inclou un paginador de forma nativa però al incloure *Doctrine* permet implementar-ho fàcilment sense necessitat d'instal·lar nous components. A continuació presentarem tres possibles opcions d'implementació.

### La classe Paginator de Doctrine

En aquest cas crearíem nous mètodes en el repositori. `findAllPaginated` crea la consulta i la passa al mètode 
`paginate` que serà el que farà la paginació.

El mètode `paginate` ens tornarà un objecte Paginator que conté en la propietat Paginator::results els resultats.

Ens faltaria obtenir el total de registres la qual cosa és ben senzilla ja que la classe `Paginator` implementa la 
interfície `Countable` i simplement usant el mètode `count()` obtindrem el total de registres.

```php
use Doctrine\ORM\Tools\Pagination\Paginator;
...
public function findAllPaginated($currentPage = 1):?Paginator
{
    $query = $this->createQueryBuilder('l')
        ->orderBy('l.createdAt', 'DESC')
        ->getQuery();

    // No need to manually get get the result ($query->getResult())
    $paginator = $this->paginate($query, $currentPage);

    return $paginator;
}

// Paginate results. 
public function paginate($dql, $page = 1, $limit = 5):?Paginator
{
    $paginator = new Paginator($dql);

    $paginator->getQuery()
    ->setFirstResult($limit * ($page - 1)) // Offset
    ->setMaxResults($limit); // Limit

    return $paginator;
}
```

Més informació  en [Pagination](https://www.doctrine-project.org/projects/doctrine-orm/en/2.7/tutorials/pagination.html) i
 [Symfony and Doctrine pagination with Twig](https://anil.io/blog/symfony/doctrine/symfony-and-doctrine-pagination-with-twig/)

### Classe `Paginator` de symfony/demo
Un altra opció és fer ús de la classe `Paginator` que s'utilitza en el projecte d'exemple de Symfony. Empra la classe
`Paginator` de Doctrine i ens proporciona tots els mètodes necessaris per a fer la paginació.

 * Classe [Paginator](https://github.com/symfony/demo/blob/master/src/Pagination/Paginator.php).
 * Repositori [PostRepositori:findLatest](https://github.com/symfony/demo/blob/master/src/Repository/PostRepository.php).
 * Mètode [BlogController::index()](https://github.com/symfony/demo/blob/master/src/Controller/BlogController.php).
 * Plantilla de Twig [blog/index.html.twig](https://github.com/symfony/demo/blob/master/templates/blog/index.html.twig).

### knplabs/knp-paginator-bundle
Paginator per a Symfony automatitza la paginació i simplifica l'ordenació i altres característiques.

En la descripció del paquet [knplabs/knp-paginator-bundle](https://packagist.org/packages/knplabs/knp-paginator-bundle) 
obtindreu més informació.

## Recursos
* [https://anil.io/blog/symfony/doctrine/symfony-and-doctrine-pagination-with-twig/](https://anil.io/blog/symfony/doctrine/symfony-and-doctrine-pagination-with-twig/)
* [https://www.drauta.com/como-paginar-los-resultados-con-doctrine](https://www.drauta.com/como-paginar-los-resultados-con-doctrine)
* [https://symfony.com/doc/current/components/http_foundation.html#request](https://symfony.com/doc/current/components/http_foundation.html#request)
* [http://zetcode.com/symfony/request/](http://zetcode.com/symfony/request/)

