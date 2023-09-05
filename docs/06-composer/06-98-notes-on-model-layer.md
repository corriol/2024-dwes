# Notes on model layer implementation


https://stackoverflow.com/questions/48805723/repository-and-data-mapper-coupling

* The db operations should be performed through adapters (MySqliAdapter, PdoAdapter, etc). So, the db connections are injected into adapters, not into the mappers. And certainly not in the repositories, because then the abstraction purpose of the repositories would be pointless.
* A mapper receives adapter(s) as dependencies and can receive other mappers too.
* The mappers are passed as dependencies to the repositories.
* A repository name is semantically related to the domain layer names, not really to the ones of the service layer. E.g: "InputService": ok. "InputRepository": wrong. "CountryRepository": correct.
* A service can receive more repositories. Or mappers, if you don't want to apply the extra layer of repositories.
  In the code, the only tightly coupled structure is the Country object (entity or domain object) - dynamically created for each fetched table row. Even this could be avoided through the use of a domain objects factory, but I, personally, don't see it really necessary.

P.S: Sorry for not providing a more documented code.

Service

```php
class InputService {

    private $countryRepository;
    private $productRepository;

    public function __construct(CountryRepositoryInterface $countryRepository, ProductRepositoryInterface $productRepository) {
        $this->countryRepository = $countryRepository;
        $this->productRepository = $productRepository;
    }

    public function getInitialData() {
        $products = $this->productRepository->findAll();
        $country = $this->countryRepository->findByName('England');

        //...

        return // resulted data
    }

}

```
Repository

```php
class CountryRepository implements CountryRepositoryInterface {

    private $countryMapper;

    public function __construct(CountryMapperInterface $countryMapper) {
        $this->countryMapper = $countryMapper;
    }

    public function findByPrefix($prefix) {
        return $this->countryMapper->find(['prefix' => $prefix]);
    }

    public function findByName($name) {
        return $this->countryMapper->find(['name' => $name]);
    }

    public function findAll() {
        return $this->countryMapper->find();
    }

    public function store(CountryInterface $country) {
        return $this->countryMapper->save($country);
    }

    public function remove(CountryInterface $country) {
        return $this->countryMapper->delete($country);
    }

}
```
Data mapper

```php
class CountryMapper implements CountryMapperInterface {

    private $adapter;
    private $countryCollection;

    public function __construct(AdapterInterface $adapter, CountryCollectionInterface $countryCollection) {
        $this->adapter = $adapter;
        $this->countryCollection = $countryCollection;
    }

    public function find(array $filter = [], $one = FALSE) {
        // If $one is TRUE then add limit to sql statement, or so...
        $rows = $this->adapter->find($sql, $bindings);

        // If $one is TRUE return a domain object, else a domain objects list.
        if ($one) {
            return $this->createCountry($row[0]);
        }

        return $this->createCountryCollection($rows);
    }

    public function save(CountryInterface $country) {
        if (NULL === $country->id) {
            // Build the INSERT statement and the bindings array...
            $this->adapter->insert($sql, $bindings);

            $lastInsertId = $this->adapter->getLastInsertId();

            return $this->find(['id' => $lastInsertId], true);
        }

        // Build the UPDATE statement and the bindings array...
        $this->adapter->update($sql, $bindings);

        return $this->find(['id' => $country->id], true);
    }

    public function delete(CountryInterface $country) {
        $sql = 'DELETE FROM countries WHERE id=:id';
        $bindings = [':id' => $country->id];

        $rowCount = $this->adapter->delete($sql, $bindings);

        return $rowCount > 0;
    }

    // Create a Country (domain object) from row.
    public function createCountry(array $row = []) {
        $country = new Country();

        /*
         * Iterate through the row items.
         * Assign a property to Country object for each item's name/value.
         */

        return $country;
    }

    // Create a Country[] list from rows list.
    public function createCountryCollection(array $rows) {
        /*
         * Iterate through rows.
         * Create a Country object for each row, with column names/values as properties.
         * Push Country object object to collection.
         * Return collection's content.
         */

        return $this->countryCollection->all();
    }

}

```
Db adapter

```php
class PdoAdapter implements AdapterInterface {

    private $connection;

    public function __construct(PDO $connection) {
        $this->connection = $connection;
    }

    public function find(string $sql, array $bindings = [], int $fetchMode = PDO::FETCH_ASSOC, $fetchArgument = NULL, array $fetchConstructorArguments = []) {
        $statement = $this->connection->prepare($sql);
        $statement->execute($bindings);
        return $statement->fetchAll($fetchMode, $fetchArgument, $fetchConstructorArguments);
    }

    //...
}

```
Domain objects collection

```php
class CountryCollection implements CountryCollectionInterface {

    private $countries = [];

    public function push(CountryInterface $country) {
        $this->countries[] = $country;
        return $this;
    }

    public function all() {
        return $this->countries;
    }

    public function getIterator() {
        return new ArrayIterator($this->countries);
    }

    //...
}

```
Domain object

```php
class Country implements CountryInterface {
    // Business logic: properties and methods...
}

```






DataMapper is a layer to isolate an application from a concrete database. It transforms an object into a record of a database and a record into an object. DataMapper gives us the ability to work with Database and be unaware of what RDBMS we use. Example:

```php
interface DataMapperInterface
{

    /**
     * Find objects by a criteria
     *
     * @param array $criteria Search params
     * @return Quote[] Found entities
     */
    public function find(array $criteria);

    /**
     * Insert an object into a database
     *
     * @param Quote $object Object that will be inserted
     */
    public function insert(Quote $object);

    /**
     * Update an object date in a database
     *
     * @param Quote $object Object that will be updated
     */
    public function update(Quote $object);

    /**
     * Remove an object from a database
     *
     * @param Quote $object Object that will be removed
     */
    public function delete(Quote $object);
}

```
Repository is a layer for encapsulation of logic of a query building. It gives us the ability to work with a collection of objects and be unaware to work with Database anything.

```php
class Repository
{

   /**
    * @var DataMapperInterface Mapper to transform objects
    */ 
   protected $mapper;

   /**
    * Constructor
    *
    * @param DataMapperInterface $mapper Mapper to transform objects
    */
   public function __construct(DataMapperInterface $mapper)
   {
       $this->mapper = $mapper;
   }

   /**
    * Find all objects
    *
    * @return Quote[] Found entities
    */
   public function findAll()
   {
       return $this->mapper->find([]);
   }

   /**
    * Find an object by an identifier
    *
    * @return Quote[] Found entities
    */
   public function findById(integer $id)
   {
       $criteria = ['id' => $id];
       return $this->mapper->find($criteria);
   }

   /**
    * Find objects by an author name
    *
    * @return Quote[] Found entities
    */
   public function findByAuthor($name)
   {
       $criteria = ['author' => $name];
       return $this->mapper->find($criteria);
   }

   /**
    * Save an object into the repository
    */
   public function save(Quote $object)
   {
       if (empty($object->id)) {
           $this->mapper->insert($object);
       } else {
           $this->mapper->update($object);
       }
a    }

   /**
    * Remove an object from the repository
    */
   public function remove(Quote $object)
   {
       $this->mapper->delete($object);
   }
}
```

This is the very simple instance and all is more difficult in a real application: queries are bigger, repository can cooperate with many other patterns (Query Object to query building, Unit of Work to track changes, Identity Map to avoid repeatedly-load of objects, etc.)
