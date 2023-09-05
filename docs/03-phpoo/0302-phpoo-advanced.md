# PPO en PHP. Conceptes avançants

## Mètodes i propietats estàtiques

Els mètodes i propietats estàtics (o de classe) són aquells accessibles directament des de la classe, sense necessitat
d'instànciar-la.

Es declaren amb la paraula reservada `static` i s'accedeix a ells amb l'operador d'àmbit `::`.

Si volem accedir a un mètode estàtic, es posa davant el nom de la classe:

```php
Product::newProduct().
```

Si des d'un mètode volem accedir a una propietat estàtica de la mateixa classe, s'utilitza la referencia `self`: `self::$numberOfProducts`

```php
class Product {
    const IVA = 0.23;
    private static $numberOfProducts = 0; 

    public static function newProducts() {
        self::$numberOfProducts++;
    }
}

Product::newProducts();
$tax = Product::IVA;
```

També podem tindre classes normals que tinguen alguna propietat estàtica:

```php
class Product {
    const IVA = 0.23;
    private static int $numberOfProducts = 0; 
    private string $code;

    public function __construct(string $code) {
        self::$numOfProducts++;
        $this->code = $code;
    }

    public function getSummaryLine() : string {
        return "El producte ".$this->code." és el número ".self::$numOfProducts;
    }
}

$prod1 = new Product("PS5");
$prod2 = new Product("XBOX Series X");
$prod3 = new Product("Nintendo Switch");
echo $prod3->getSummaryLine();
``` 

## Classes abstractes 

Les classes abstractes són classes que no es poden instanciar, per la qual cosa actuaran de superclasse i serà obligatori crear subclasses per a fer ús d'ella. És a dir, una classe amb el modificador `abstract` no pot tenir objectes que la instancien, però sí podrà utilitzar-se de classe base i les seues subclasses sí podran utilitzar-se per a instanciar objectes.

```php
abstract class Product {
   ...
}
```

### Mètodes abstractes

Un mètode en el qual s'indique `abstract`, ha de ser redefinit obligatòriament per les subclasses, i no podrà contenir codi.

```php
class Product {
        …
    abstract public function show();
}
```

Anem a fer una petita modificació en la nostra classe `Product`. Per a
facilitar la creació de nous objectes, crearem un constructor al que se
li passarà un array amb els valors dels atributs del nou producte.

```php
class Product {
    public $code;
    public $name;
    public $shortName;
    public $price;
    
    public function show(): void {
        echo "<p>" . $this->code . "</p>";
    }
    public function __construct($row) {
        $this->code = $row['code'];
        $this->name = $row['name'];
        $this->shortName = $row['short_name'];
        $this->price = $row['price'];
    }
}
```

!!! question "Questió"

    **Què passa ara amb la classe `TV`, què hereta de `Product`? Quan crees un
    nou objecte d'aqueixa classe, es cridarà al constructor de Product?
    Pots crear un nou constructor específic perquè redefinisca el
    comportament de la classe base?**

Començant per aquesta última pregunta, òbviament pots definir un nou
constructor per a les classes heretades que redefinisquen el
comportament del que existeix en la classe base, tal com faries amb
qualsevol altre mètode. I depenent de si programes o no el constructor
en la classe heretada, es cridarà o no automàticament al constructor de
la classe base.

En PHP5+, si la classe heretada no té constructor propi, es cridarà
automàticament al constructor de la classe base (si existeix). No
obstant açò, si la classe heretada defineix el seu propi constructor,
hauràs de ser tu el que realitze la crida al constructor de la classe
base si ho consideres necessari, utilitzant per a açò la paraula
`parent` i l'operador de resolució d'àmbit.

```php
class TV extends Product {
    public $size;
    public $technology;
    
    public function show() {
        print "<p>" . $this->size . " polzades</p>";
    }
    
    public function __construct($row) {
        parent::__construct($row);
        $this->size = $row['size'];
        $this->technology = $row['technology'];
    }
 }
```

Ja has vist amb amb anterioritat com s'utilitzava la paraula clau `self`
per a tenir accés a la classe actual. La paraula `parent` és semblant. En
utilitzar `parent` fas referència a la classe base de la actual, tal com
apareix rere `extends`.


## Interfícies

Un interfície (*interface*) és com una classe buida que solament conté declaracions de mètodes. 
Es defineixen utilitzant la paraula `interface`. Per exemple, abans vam veure que podíem crear noves classes
heretades de `Product`, com `TV` o `Ordinador`. També vam veure que en les subclasses
podies redefinir el comportament del mètode perquè generara una eixida
en HTML diferent per a cada tipus de producte.

Si vols assegurar-te que tots els tipus de productes tinguen un mètode
`show`, pots crear un interface com el següent.

```php
interface IShow {
    public function show(): Void;
}
```

I quan crees les subclasses hauràs d'indicar amb la paraula `implements`
que han de implementar els mètodes declarats en aquest interface.

```php
class TV extends Product implements IShow {
            …
    public function show() {
        echo "<p>" . $this->size . " polzades</p>";
    }
        …
}
```

Tots els mètodes que es declaren en un `interface` han de ser públics. A
més de mètodes, els interfícies podran contenir constants però no
atributs.

Un interface és com un contracte que la classe ha de complir. En
implementar tots els mètodes declarats en la interfície s'assegura la
interoperabilitat entre classes. Si saps que una classe implementa un
interfície determinada saps quins noms tenen els seus mètodes, quins
paràmetres els has de passar i, probablement, podràs esbrinar fàcilment
amb quins objectiu han sigut escrits.

Per exemple, en la llibreria de PHP està definit la interfície
`countable`.

```php
Countable {
    abstract public int count(void)
}
```

Si crees una classe per a la cistella de la compra en la tenda web,
podries implementar aquesta interfície per a contar els productes que
figuren en la mateixa.

Abans vas aprendre que en PHP5 una classe només pot heretar d'una altra.
En PHP5 no existeix l'herència múltiple. No obstant açò, sí és possible
crear classes que implementen diverses interfícies, simplement separant
la llista d'interfícies per comes després de la paraula `implements`.

```php

class TV extends Product implements IShow, Countable {
         …
}
```

L'única restricció és que els noms dels mètodes que s'hagen
d'implementar en els diferents interfícies no coincidisquen. És a dir,
en el nostre exemple, la interfície `IShow` no podria contenir el
mètode `count`, doncs aquest ja està declarat en `Countable`.

Des de PHP7 també es poden crear nous interfícies heretant d'uns altres ja
existents. Es fa de la mateixa forma que amb les classes, utilitzant la
paraula `extends`.

## Classes abstractes vs interfícies

Un dels dubtes més comuns en POO, és quina solució adoptar en algunes
situacions: interfícies o classes abstractes. Ambdues permeten definir
regles per a les classes que els implementen o hereten respectivament. I
cap permet instanciar objectes. Les diferències principals entre ambdues
opcions són:

  - En les classes abstractes, els mètodes poden contenir codi. Si van a
    existir diverses subclasses amb un comportament comú, es podria
    programar en els mètodes de la classe abstracta. Si s'opta per un
    interface, caldria repetir el codi en totes les classes que ho
    implemente.
  - Les classes abstractes poden contenir atributs, i les interfícies
    no.
  - No es pot crear una classe que herete de dues classes abstractes,
    però sí es pot crear una classe que implemente diverses interfícies.

Per exemple, en la botiga *online* va a haver-hi dos tipus d'usuaris:
clients i empleats. Si necessites crear en la teua aplicació objectes de
tipus Usuari (per exemple, per a manejar de forma conjunta als
clients i als empleats), hauries de crear una classe no abstracta amb
aqueix nom, de la qual heretarien Client i Empleat.

Podeu llegir també l'article
 [Clases abastractas e interfaces en PHP ](https://poesiabinaria.net/2010/06/clases-abstractas-e-interfaces-en-php/)


```php
class Usuari {
     ...
}
class Client extends Usuari {
...
}
class Empleat extends Usuari {
...
}

```

Però si no fóra així, hauries de decidir si crees o no `Usuari`, i si ho
faries com una classe abstracta o com una interfície.

Si per exemple, volgueres definir en un únic lloc els atributs comuns a
Client i a Empleat, hauries de crear una classe abstracta Usuari de la
qual hereten.

```php
abstract class Usuari {
    public string $dni;
    
    protected string $nom;
        ...
}
```

Però açò no podries fer-ho si ja tens planificada alguna relació
d'herència per a una d'aquestes dues classes.

Per a finalitzar amb les interfícies, a la llista de funcions de PHP
relacionades amb la POO pots afegir les següents.

| Funció                     | Exemple                                  | Significat                                                                  |
| -------------------------- | ---------------------------------------- | --------------------------------------------------------------------------- |
| get\_declared\_interfícies | print\_r (get\_declared\_interfícies()); | Retorna un array amb els noms dels interfícies declarats.                   |
| interface\_exists          | if (interface\_exists('iShow') { … }  | Retorna true si existeix l'interface que s'indica, o false en cas contrari. |

## Trets (Traits)

Des de la seva versió 5.4.0, PHP implementa una metodologia de
reutilització de codi anomenada `Traits`.


Els trets («traits» en anglès) són un mecanisme de reutilització de
codi en llenguatges d'herència simple, com PHP. L'objectiu d'un tret és
el de reduir les limitacions pròpies de l'herència simple permetent que
els desenvolupadors reutilitzen a voluntat conjunts de mètodes sobre
diverses classes independents i pertanyents a classes jeràrquiques
diferents. 

Un Trait és similar a una classe, però amb l'únic objectiu d'agrupar
funcionalitats molt específiques i d'una manera coherent. No es pot
instanciar directament un `Trait`. És per tant un afegit a l'herència
tradicional, i habilita la composició horitzontal de comportaments; és a
dir, permet combinar membres de classes sense haver d'usar herència.

```php   
trait Saludar {
    function decirHola(){
        return "hola";
    }
}
trait Despedir {
    function decirAdios(){
        return "adiós";
    }
}
class Comunicacion {
    use Saludar, Despedir;
}
$comunicacion = new Comunicacion;
echo $comunicacion->decirHola() . ", que tal. " . $comunicacion->decirAdios();
```

En l'exemple anterior la classe `Comunicacion` necessita reutilitzar els mètodes `Saludar::decirHola()` i 
`Despedir::decirAdios()` com que en PHP no hi ha herència múltiple mitjançant els `trait` es pot aconseguir 
reutilitzar-les.

## Clonació d'Objectes

Per crear una còpia d'un objecte s'utilitza la paraula clau `clone` (que
invoca, si fos possible, al mètode  `__clone()` de l'objecte). No es pot
cridar el mètode `__clone()` d'un objecte directament.

```php
$copia_objecte = clone $objecte;
```

Quan es clona un objecte, PHP7 durà a terme una còpia superficial de les
propietats de l'objecte. Les propietats que siguen referències a altres
variables (per exemple, objectes), mantindran les referències.

Compte: si els atributs són objectes no es clonaran.

## Classes i mètodes finals

Existeix una forma d'evitar que les classes heretades puguen redefinir
el comportament dels mètodes existents en la superclasse: utilitzar la
paraula `final`.

Si en el nostre exemple haguérem fet:

```php
class Product { 
    public string $code; 
    public string $name;         
    public float $price;
    
    public final function show() {
        print "<p>" . $this->code . "</p>";
    }
}
```

En aquest cas el mètode `show` no podria redefinir-se en la classe `TV`.

També es pot declarar una classe utilitzant `final`. En aquest cas no
podran crear-se classes heretades utilitzant-les com a base.

```php
final class Product {
  ...
}
```


## Mètodes màgics

Totes les classes PHP ofereixen un conjunt de mètodes, també coneguts com a *mètodes màgics* que es poden sobreescriure per substituir el seu comportament. Alguns d’ells ja els han utilitzat.

Davant de qualsevol dubte, és convenient consultar la [documentació oficial](https://www.php.net/manual/es/language.oop5.magic.php).

Els més destacables són:

* `__construct()`
* `__destruct ()` → S'invoca en perdre la referència. S'utilitza per tancar una connexió amb una base de dades, tancar un fitxer, etc.
* `__toString ()` → representació de l'objecte com a cadena
* `__get(propietat)`, `__set(propietat, valor)` → permetria l'accés a la propietat privada, tot i que sempre és més llegible/mantenible codificar el *getter/setter*.
* `__isset(propietat)`, `__unset (propietat)` → us permet esbrinar o eliminar el valor d'una propietat.
* `__sleep()`, `__wakeup ()` → S'executen quan es recuperen (*Unserialize*) o emmagatzemen un objecte serialitzat (*serialitze*), i s'utilitzen per definir quines propietats estan serialitzades.
* `__call ()`, `__callstatic ()` → s'executen cridant a un mètode que no siga públic. Permeten mètodes de sobrecàrrega.

## Espai de noms

Des de PHP 5.3 permeten organitzar classes/interfícies, funcions o constant de manera similar als paquets *java*.

!!! tip "Recomanació"    
    Crea un espai de nom únic per fitxer i creeu una estructura de directoris respecte als nivells/subnivells (com es fa a *java*)

Es declara a la primera línia per la paraula clau `namespace` seguit del nom de l'espai de nom assignat (cada subnivell està separat amb la barra invertida `\`):

Per exemple, per col·locar la classe `Product` dins de l'espai de noms `Dwes\Examples` faríem:

```php
<?php

namespace Dwes\Examples;

const IVA = 0.21;

class Product {
    public string $name;
      
    public function show(): void {
        echo "<p> prod:". $ this-> name . "</p>";
    }
}
```

### Accés

Per fer referència a un recurs que conté un espai de noms, primer cal tenir -lo disponible mitjançant `include` o `require`. Si el recurs es troba al mateix espai de noms, es fa un accés directe (es coneix com a accés sense qualificar).

Hi ha realment tres tipus d’accés:

* Sense qualificar: `recurs`
* Qualificat: `\rutaRelativa\recurs`. No cal posar l'espai de noms complet.
* Totalment qualificat: `\rutaAbsoluta\recurs`

``` php
<?php
namespace Dwes\Examples;

include_once("Product.php");

echo IVA; // sin cualificar
echo Utils\IVA; // acceso cualificado. Daría error, no existe \Dwes\Exemples\Utilitats\IVA
echo \Dwes\Exemples\IVA; // totalmente cualificado

$p1 = new Product(); // lo busca en el mismo namespace y encuentra \Dwes\Ejemplos\Producto
$p2 = new Model\Product(); // daría error, no existe el namespace Model. Está buscando \Dwes\Ejemplos\Model\Producto
$p3 = new \Dwes\Examples\Product(); // \Dwes\Ejemplos\Producto
```

Per a evitar la referència qualificada podem declarar l'ús mitjançant `use` (similar a fer un `import` en *Java*). Es faria 
en la capçalera, després del `namespace`:

Els tipus possibles són:

* `use const nomQualificatConstant`
* `use function nomQualificatFuncio`
* `use nomQualificatClasse`
* `use nomQualificatClase as Alias` // per a canviar de nom elements

Per exemple, si volem utilitzar la classe `\Dwes\Examples\Product` des d'un recurs que es trobe en l'arrel, per exemple en `index.php`, faríem:

``` php
<?php
include_once("Dwes\Examples\Product.php");

use const Dwes\Exemples\IVA;
use \Dwes\Exemples\Product;

echo IVA;
$p1 = new Product();
```

!!! tip "To `use` or not to `use`"
    En resum, `use` permit acceder sense haver de qualificar-los a recursos que es troben en un altre *namespace*. Si estem en el mateix espai de noms, no necesitem usar `use`.

### Organització

Cada projecte, a mesura que creix, ha d’organitzar el seu codi font. Es planteja una organització en què els fitxers que interaccionen amb el navegador es col·loquen a l’arrel i les classes que definim entra dins d’un `namespace`.


!!! tip "Organització, _includes_ i _uses_"
    * Posarem cada recurs en un fitxer independent.
    * A la primera línia indicarem el seu _namespace_ (si no està a l'arrel).
    * Si utilitzem altres recursos, farem un `include_once` d'aquests recursos (classes, interfícies, etc ...).
        * Cada recurs ha d’incloure tots els altres recursos a què faça referència: la classe dels quals hereta, interfícies que implementen, les classes utilitzades/rebudes com a paràmetres, etc.
    * Si els recursos es troben en un espai de noms diferents dels que som, utilitzarem `use` amb la ruta completa i, a continuació, l'utilitzarem sense referències qualificades.

### Autoload

No és tediós haver de fer els `require` de les classes? La funcionalitat _autoload_ arriba al rescat.

Així, aquesta funcionalitat permet que les classes  que s’utilitzaran es carreguen automàticament i eviten haver de fer el `include_once` de cadascuna d'elles. Per fer-ho s'utilitza la funció `spl_autoload_register`

``` php
<?php
spl_autoload_register( function( $nombreClase ) {
    include_once $nombreClase.'.php';
} );
?>
```

!!! question "¿Per què s'anomena _autoload_?"
    Perquè abans es realitzaba mitjançant el mètode màgic `__autoload()`, el qual està *deprecated* des de PHP 7.2

I com organitzem ara el codi per aprofitar-nos de la càrrega automàtica?

Per facilitar la cerca dels recursos per incloure, és recomanable posar totes les classes de la mateixa carpeta. Les  situarem dins de `src` (no és obligatori, és la convenció que seguirem). Altres directoris que podem crear són `test` per fer les proves _phpunit_ que després realitzarem, o la carpeta del _views_ on s’emmagatzemaran les vistes del projecte.

Com que hem col·locat tots els nostres recursos dins de `src`, ara el nostre `autoload.php` (que col·loquem al directori arrel) només mirarà dins d’aquest directori:

``` php
<?php
spl_autoload_register( function( $className ) {
    include_once "src/".$className.'.php';
} );
?>
```

!!! danger "Autoload i rutes errònies"

    A Ubuntu, quan fa la classe que rep com a paràmetre, les barres de l’espai de noms (`\`) són diferents de les de les rutes (`/`).Per tant, utilitzem millor aquesta implementació del fitxer `autoload.php`:

    ```php
    <?php
    spl_<?php
    spl_autoload_register(function($className) {
        $ruta = "src\\".$className.'.php';
        $ruta = str_replace("\\", "/", $ruta); // Sustituimos las barras
        include_once $ruta;
    }
    );

    ```



## Bibliografia

  - José Luis Comesaña.  *Apuntes de formación a distancia del módulo
    «Desarrollo web en entorno servidor» del CFGS DAW, elaborados y
    licenciados por el Ministerio de Educación, Cultura y Deporte.* \[en
    línia\]. 2012 \[data de consulta: 13 de setembre de 2019\].
    Disponible en
    \<<https://github.com/statickidz/TemarioDAW/tree/master/DWES>\>
  - Antonio López. *Learning PHP 7.* Packt Publishing (29 de marzo de
    2016).
  - Medrano, Aitor, i Luis Alemañ. «3.- PHP Orientado a Objetos - Desarrollo Web en Entorno Servidor». Desarrollo Web en Entorno Servidor, <https://aitor-medrano.github.io/dwes2122/03phpoo.html>. Consulta 15 octubre 2022.

