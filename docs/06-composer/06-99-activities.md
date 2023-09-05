# Activitats

## Projecte Truiter

### Introducció

601. La classe `FlashMessage`. 
     
     Fins ara, hem gestionat la comunicació entre pàgines mitjançant sessions. 
     La gestió la fèiem escrivint i llegint en les variables de sessió. L'objectiu de la següent classe és proporcionar-nos un mecanisme que ens facilite l'enviament de missatges entre pàgines. Una vegada implementada utilitza-la en la creació de pel·lícules.

```php
# src/App/Helpers/FlashMessage.php
/**
 * Class FlashMessage
 * Aquesta classe llig i escriu directament en una variable de sessió 
 * que serà un array, la clau serà $sessionKey  de forma que evitem 
 * possible col·lisions.
*/
class FlashMessage
{
    /**
     * string
     */
    
    const SESSION_KEY = "flash-message";

    /**
     * obtenim el valor de l'array associat a la clau.
     * després de llegir-lo l'esborrem
     * si no existeix tornem el valor indicat per defecte.
     * @param string $key
     * @param mixed $defaultValue
     * @return mixed|string
     */
    public static function get(string $key, $defaultValue = '');

    /**
     * @param string $key
     * @param $value
     */
    public static function set(string $key, $value);

    /**
     * @param string $key
     */
    private static function unset(string $key);      
}
```

602.  Tenint en compte tot el procés de gestió de pujada de fixers, les restriccions que es poden aplicar, i les dades que ens interessen una vegada el procés s'ha efectuat exitosament, crea una classe [`UploadedFileHandler.php`](asssets/../assets/UploadedFileHandler.php) que encapsule totes les funcionalitats requerides. Completa la jerarquia d'excepcions.
     

603. Implementa la classe `App\Helpers\Validator` que tindrà mètodes estàtics per fer validacions, de moment aquestos:
     1. `lengthBetween(string $value,int $min,int $max, string $message = '')`
     2. `regex(string $value, string $pattern, string $message = '')`

En cas d'error caldrà llançar una excepció `InvalidArgumentException`. 

604. Implementa la classe `App\Services\DB` publicada en [A simple PDO class](https://phpdelusions.net/pdo/pdo_wrapper#class). Utilitza-la allà on calga operar en la base de dades.

605. Implementa el patró `Registry` en una classe amb el mateix nom i afegeix una instancia de `DB` associada a la clau "DB". L'objecte `DB` l'hauràs de crear i inserir-lo en el `Registry` en un nou fitxer anomenat `bootstrap.php`.

    Aquest fitxer serà requerit en totes els fitxers que tinguen accés a la base de dades.

606. En un fitxer de configuració (JSON, YAML, INI o XML, segons t'haja assignat el professor) emmagatzema el DSN (_Data Source Name_) d'accés a la base de dades. Després, crea una classe `Config` que llija el fitxer i extraga el DSN. Utilitza `Config` en `bootstrap.php` en lloc d'usar un literal en instanciar la classe PDO.

    Afig també al fitxer de configuració la ruta relativa on es guarden les fotos pujades.

607.  Refacciona tota la aplicació perquè s'utilitzen les noves classes introduides, així com els repositoris i els mètodes que necessites. 

### Composer

608. En la següent activitat treballarem en Composer:

       1. Instal·la `composer` de forma global. 
       2. Instal·la `monolog`.
       3. Configura `bootstrap.php` perquè use l’autoloader de `Composer`.
       4. Configura `composer.json` perquè carregue les nostres classes.
       5. Configura `monolog` en `index.php` de forma que registre la activitat en `directori del projecte/var/logs/app.log` i en Firefox amb l'extensió FirePHP.

609. `webmozart/assert` és un paquet que conté una llibreria de funcions de validació (assercions/afirmacions).

    1. Instal·la el paquet.
    2. Configura'l si cal.
    3. Usa els seus mètodes per a validar els formularis.    


