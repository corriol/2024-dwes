# POO en PHP. Conceptes bàsics

## Introducció

La programació orientada a objectes (OOP, per les seues sigles en
anglès) és un paradigma de programació.

Paradigma:

> Teoria […] el nucli central de la qual \[…\] suministra la base i el
> model per resoldre problemes i avançar en el coneixement.

Per la qual cosa podem definir la programació orientada a objecte com
un mètode -provat i estudiat- el qual es basa en les interaccions
d'objectes per resoldre les necessitats d'un sistema informàtic.

Un objecte és una estructura que conté dades i el codi que els maneja.

L'estructura dels objectes es defineix en les classes. En elles s'escriu
el codi que defineix el comportament dels objectes i s'indiquen els
membres que formaran part dels objectes d'aquesta classe. Entre els
membres de una classe pot haver-hi:

  - **Mètodes**. Són els membres de la classe que contenen el codi de la
    mateixa. Un mètode és com una funció. Pot rebre paràmetres i
    retornar valors.
  - **Atributs o propietats**. Emmagatzemen informació sobre el estat de
    l'objecte al que pertanyen (i per tant, el seu valor pot ser
    diferent per a cadascun dels objectes de la mateixa classe).

A la creació d'un objecte basat en una classe se li anomena **instanciar
una classe** i a l'objecte obtingut també se li coneix com a **instància**
d'aqueixa classe.

Els pilars fonamentals de la POO són:

  - **Herència**. És el procés de crear una classe a partir de una altra,
    heretant el seu comportament i característiques i podent
    redefinir-los.
  - **Abstracció**. L'objectiu principal es gestionar la complexitat ocultant detalls innecessaris a l'usuari. Això li permet implementar lògica més complexa sobre la base de la abstracció sense entendre o, inclús, sense pensar en tota la seua complexitat oculta.
  - **Polimorfisme**. Un mateix mètode pot tenir comportaments diferents en
    funció de l'objecte amb que s'utilitze.
  - **Encapsulació**. La idea és mantindre en una mateix lloc (unitat de codi) les dades i el
    codi que els manipula. Aquest concepte també s'utilitza sovint per ocultar la representació interna, o estat, d'un objecte des de l'exterior. Això s'anomena *ocultació d'informació*.

Els avantatges més importants que aporta la programació orientada a
objectes són:

  - **Modularitat**. La POO permet dividir els programes en parts o
    mòduls més xicotets, que són independents uns d'uns altres però
    poden comunicar-se entre ells.
  - **Extensibilitat**. Si es desitgen afegir noves característiques a
    una aplicació, la POO facilita aquesta tasca de dues formes: afegint
    nous mètodes al codi, o creant nous objectes que estenguen el
    comportament dels ja existents.
  - **Manteniment**. Els programes desenvolupats utilitzant POO són més
    senzills de mantenir, a causa de la modularitat abans comentada.
    També ajuda seguir certes convencions en escriure'ls, per exemple,
    escriure cada classe en un fitxer propi. No ha d'haver-hi dues
    classes en un mateix fitxer, ni un altre codi a part del propi de
    la classe.
    
## Característiques bàsiques de l'ús d'objectes en PHP

Segurament tot, o la majoria del que acabes de veure, ja ho coneixies,
i és fins i tot probable que sàpigues utilitzar algun llenguatge de
programació orientat a objectes, així que anem a veure directament les
peculiaritats pròpies de PHP en el que fa referència a la POO.

En PHP podemos utilitzar els dos paradigmes de la programació: estructurada i orientada a objectes.

```php
 // utilitzant programació estructurada
$dwes = mysqli_connect('localhost', 'dwes', 'abc123.', 'dwes');
// utilizant POO
$dwes = new mysqli();
$dwes->connect('localhost', 'dwes', 'abc123.', 'dwes');
```

No obstant açò, el llenguatge PHP original no es va dissenyar amb
característiques d'orientació a objectes. Només a partir de la versió 3,
es van començar a introduir alguns trets de POO en el llenguatge. Açò es
va potenciar en la versió 4, encara que encara de forma molt
rudimentària. Per exemple, en PHP4:

  - Els objectes es passen sempre per valor, no per referència.
  - No es pot definir el nivell d'accés per als membres de la classe.
    Tots són públics.
  - No existeixen les interfícies.
  - No existeixen mètodes destructors.

En PHP5 es va reescriure i potenciar el suport d'orientació a objectes del llenguatge, ampliant les seues
característiques i millorant el seu rendiment i el seu funcionament general. Les característiques de POO que 
suporta PHP5 inclouen:

  - Mètodes estàtics.
  - Mètodes constructors i destructors.
  - Herència.
  - Interfícies.
  - Classes abstractes.

Entre les característiques que no inclou PHP5, i que pots conèixer
d'altres llenguatges de programació, estan:

  - Herència múltiple.
  - Sobrecàrrega de mètodes (tenir diversos mètodes amb el mateix nom,
    però amb funcionalitats diferents. Els mètodes sobrecarregats han de
    tenir diferents paràmetres. Quan es diu al mètode, s'utilitza una o
    una altra versió en funció dels paràmetres amb que es realitze la
    trucada (podent distingir per el seu nombre i per el seu tipus,
    segons el llenguatge de programació utilitzat)) (inclosos els
    mètodes constructors).
  - Sobrecàrrega d'operadors (similar a la sobrecàrrega de mètodes. Es
    poden definir diverses funcionalitats a un mateix operador, i
    s'utilitzarà una o una altra en funció del tipus dels operands que
    s'usen en cada instant).

PHP 7 incorpora millores en el rendiment i el tipat d'arguments, valors de retorn i atributs (des de la versió 7.4)

Quant a les novetats aportades per PHP 8 cal destacar: l'operador `nullsafe`, la propagació de propietats en els constructors, la unió de tipus que permet definir tipus múltiples.

!!! important "Objectes sempre es passen per referència"

    Els objectes  que s'envien o reben com a paràmetres sempre es passen per referència.

## Definició de classes

La declaració de una classe en PHP es fa utilitzant la paraula `class`. A continuació i entre claus, han de 
figurar els membres de la classe.

Convé fer-ho de forma ordenada, primer les propietats o atributs, i
després els mètodes, cadascun amb el seu codi respectiu.

```php
class Product {
    private string $code;
    public string $name;
    public float $price;
    public function getSummaryLine(): string {
        return $this->name;
    }
}
```

En UML la classe anterior es representaria així:

``` mermaid
classDiagram
  class Product {
    -string code
    +string name
    +float price
    +string getSummaryLine()
  } 
```

Com comentàvem abans, és preferible que cada classe figure en el seu
propi fitxer (**`Product.php`**). A més, molts programadors prefereixen
utilitzar per a les classes noms que comencen per lletra majúscula, per
a, d'aquesta forma, distingir-los dels objectes i altres variables.

Una vegada definida la classe, podem usar la paraula **`new`** per a
instanciar objectes de la següent forma:

```php
$product = new Product();
```

Perquè la línia anterior s'execute sense error, prèviament hem d'haver
declarat la classe. Per a açò, en aqueix mateix fitxer hauràs de
incloure la classe posant alguna cosa com:

```php
require('Product.php');
```

Els atributs de una classe són similars a les variables de PHP. És
possible indicar un valor en la declaració de la classe. En aquest cas,
tots els objectes que s'instancien a partir de aqueixa classe, partiran
amb aqueix valor per defecte en l'atribut.

Per a accedir des d'un objecte als seus atributs o als mètodes de
la classe, has d'utilitzar l'operador fletxa (fixa't que només es posa
el símbol $ davant del nom de l'objecte):

```php
$product->name = 'Samsung Galaxy S';
echo $product->getSummaryLine(); 
```
### Visibilitat

Quan es declara una propietat o un mètode, s'ha d'indicar el seu nivell d'accés (o visibilitat). Els
principals nivells són:

  - `public`. Els atributs declarats com `public` poden utilitzar-se
    directament per els objectes de la classe. És el cas de l'atribut
    `$name` anterior.
  - `private`. Els atributs declarats com `private` només poden ser
    accedits i modificats per els mètodes definits en la classe, no
    directament per els objectes de la mateixa. És el cas de l'atribut
    `$code`.
  - `protected`. Una propietat o mètode `protected` sols pot ser accedida per la classe on es defineix o per un subclasse. No és accessible des de fora.


Un dels motius per a crear atributs privats és que el seu valor forma
part de la informació interna de l'objecte i no ha de formar part de la
seua interfície (els punts de comunicació amb altres objectes). Un altre motiu és mantenir cert control sobre els seus
possibles valors. Per exemple, si no vols que es puga canviar lliurement
el valor del codi d'un producte. O necessites conèixer quin serà el nou
valor abans d'assignar-lo. En aquests casos, se solen definir aqueixos
atributs com a privats i a més es creen dins de la classe mètodes per a
permetre'ns obtenir i/o modificar els valors d'aqueixos atributs. Per
exemple:

```php
private string $code;
public function setCode(string $newCode): boolean {
    if (!existsCode($newCode)) {
        $this->code = $newCode;
        return true;
    }
    return false;
}
public function getCode(): string { return $this->code; }
```

Encara que no és obligatori, el nom del mètode que ens permet obtenir el
valor de un atribut sol començar per `get`, i el que ens permet
modificar-lo per `set`. Aquest mètodes solen anomenar-se `getters` i `setters` o `accessors`.

## Constructor

Com ja has vist, per a instanciar objectes d'una classe s'utilitza la
paraula `new`:

```php
$product = new Product();
```

En PHP7 pots definir en les classes mètodes constructors, que s'executen
quan es crea l'objecte.

El constructor d'una classe ha d'anomenar-se `__construct`. Es poden utilitzar, per exemple, 
per assignar valors a atributs.

```php
class Product {
    
    private string $code;
    public string $name;

    public function __construct()
    {
      $this->code = "";
    }
    …
}
```

El constructor d'una classe pot cridar a altres mètodes o tenir
paràmetres, en aquest cas hauran de passar-se quan es crea l'objecte.
No obstant açò, només pot haver-hi un mètode constructor en cada classe.

```php
class Product {
    private string $code;
    public string $name;
    public function __construct(string $code) {
        $this->$code = $code;
    }
    ...
}
$product = new Product('GALAXYS');

```

Si com en aquest exemple, definim un constructor en el qual
cal passar el codi, sempre que instancies un nou objecte d'aqueixa
classe hauràs d'indicar el seu codi.

En PHP8 podem definir les propietats de la següent manera:

```php

class Product {    
    public string $name;
    public function __construct(private string $code) {        
    }
    ...
}
```
D'aquest forma ens estalviem diverses línies de codi.


## La pseuodovariable `$this`

Quan des d'un objecte s'invoca un mètode de la classe, a aquest se li
passa sempre una referència a l'objecte que ha fet la crida. Aquesta
referència s'emmagatzema en la pseudovariable `$this.` S'utilitza, per
exemple, en el codi anterior per a tenir accés als atributs privats de
l'objecte (que només són accessibles des dels mètodes de la classe).

```html+php
echo "<p>" . $this->code . "</p>";
```

## Constants de classe

A més de mètodes i propietats, en una classe també es poden definir constants, 
utilitzant la paraula `const`. És important que no confongues els atributs amb
les constants. Són conceptes diferents: les constants no poden canviar el seu 
valor (òbviament, d'ahí el seu nom), no usen el caràcter `$`, s'escriuen en 
majúscules (per convenció) i el seu valor està associat a la classe, és a dir, 
no existeix una còpia del mateix en cada objecte. 

Per tant, per a accedir a les constants d'una classe, s'ha d'utilitzar el 
nom de la classe i l'operador `::`, anomenat operador de resolució d'àmbit 
(que s'utilitza per a accedir a els elements de una classe).

```php
class DB {
    const USUARIO = 'dwes';
      ...
}
echo DB::USUARIO;
```

És important ressaltar que no és necessari que existisca cap objecte de
una classe per a poder accedir al valor de les constants que definisca.
 
!!! important "PHP-FIG"
    El PHP Framework Interop Group és un grup de treball on està involucrada gent que treballa en diferents _frameworks_ amb
    l'objectiu de posar en comú les tècniques que usen en els diferents projectes per poder integrar-les i compartir-les 
    i poder treballar millor junts.

Les recomanacions [PSR-1](https://www.php-fig.org/psr/psr-1/) i [PSR-12](https://www.php-fig.org/psr/psr-12/) 
són recomanacions sobre l'estil de programació amb l'objectiu d'aplicar estandards comuns i 
així facilitar la lectura del codi realitzar per altres.

Algunes recomancions que cal seguir:

1.  Les classes s'han de declarar en `StudlyCaps`. Per exemple: `Product`.
2.  Les constants de classes s'HAN DE declarar en majúscules i separats amb guió baix. Per exemple: `const IMAGE_PATH`.      
3.  Sobre els noms de les propietats la única recomanació és ser consistent. Així, PODEM usar `$camelCase`. La mateixa recomanació aplicarem a les variables.
4.  Els mètodes S'HAN DE declarar en `camelCase()`.

Més informació en [Estándares](http://coppeldev.github.io/php/standards/psr-1.html)


## Utilització d'objectes

Ja saps com instanciar un objecte utilitzant `new`, i com accedir a els
seus mètodes i atributs públics amb l'operador fletxa:

```php
$product = new Product();
$product->name= 'Samsung Galaxy S';
echo $product->getSummaryLine();
```

Una vegada creat un objecte, pots utilitzar l'operador `instanceof` per
a comprovar si és o no una instància de una classe determinada.

```php
if ($product instanceof Product) {
        …
}
```

Des de PHP7, pots indicar en les funcions i mètodes de quina classe han
de ser els objectes que es passen com a paràmetres. Per a açò, has
d'especificar el tipus abans del paràmetre.

```php
public function sellProduct(Product $product) {
    …
}
```

Si quan es realitza la crida, el paràmetre no és del tipus adequat, es
produeix un error que podries capturar. 

Una característica de la POO que has de tenir molt en compte és què
succeeix amb els objectes quan els passes a una funció, o simplement
quan executes un codi com el següent:

```php
$product1 = new Product();
$product1->name = 'Samsung Galaxy S';
$product2 = $product1;
```

El codi anterior simplement crearia un nou identificador del mateix objecte. Açò és,
quan s'utilitze qualsevol dels identificadors per a canviar el valor de algun atribut, aquest canvi es 
veuria també reflectit en accedir utilitzant l'altre identificador. Recorda que, encara que hi haja dos o
més identificadors del mateix objecte, en realitat tots es refereixen a l'única còpia que s'emmagatzema 
del mateix.

## Comparació d'Objectes

En utilitzar l'operador de comparació (`==`), es comparen d'una manera
senzilla les variables de cada objecte, és a dir: dues instàncies d'un
objecte són iguals si tenen els mateixos atributs i valors (els valors
es comparen amb `==`), i són instàncies de la mateixa classe.

Quan s'utilitza l'operador identitat (`===`), les variables d'un objecte
són idèntiques si i només sí fan referència a la mateixa instància de
la mateixa classe.

## Herència

L'herència és un mecanisme de la POO que ens permet definir noves
classes sobre la base d'una altra ja existent. Les noves classes que
hereten també es coneixen amb el nom de subclasses. La classe de la qual
hereten es diu classe base o superclasse.

Per exemple, en la nostra tenda web anem a tenir productes de diferents
tipus. En principi hem creat per a manejar-los una classe anomenada
`Product`, amb alguns atributs i un mètode que genera una eixida
personalitzada en format HTML del codi.

```php
class Product {
   public string $code;
   public string $name;    
  ...       
   public function show() {
      echo "<p>" . $this->code . "</p>";
   }
}
```

Aquesta classe és molt útil si l'única informació que tenim dels
diferents productes és la que es mostra dalt. Però, si vols
personalitzar la informació que vas a tractar de cada tipus de producte
(i emmagatzemar, per exemple per als televisors, les polzades que tenen
o la seua tecnologia de fabricació), pots crear noves classes que
hereten de `Product`. Per exemple, `TV`, `Computer`, `Phone`.

```php
class TV extends Product {
    public float $size;
    public string $technology;
}
```

### La paraula reservada `extends`

Com pots veure, per a definir una classe que herete d'una altra,
simplement has de utilitzar la paraula `extends` indicant la superclasse. 

Els nous objectes que s'instancien a partir de la subclasse 
són també objectes de la classe base; es pot comprovar utilitzant l'operador `instanceof`.

```php
$tv = new TV();
if ($tv instanceof Product) {
  // Aquest codi s'executa doncs la condició és certa
        …
}
```

La nova classe hereta tots els atributs i mètodes públics de la classe
base, però no els privats. Si vols crear en la classe base un mètode no
visible a l'exterior (com els privats) que s'herete a les subclasses,
has d'utilitzar la paraula **protected** en lloc de **private**. A més, pots
redefinir el comportament dels mètodes existents en la classe base,
simplement creant en la subclasse un nou mètode amb el mateix nom.

```php
class TV extends Producte { 
   public float $size;
   public string $technology;
        
   public function show() {
      print "<p>" . $this->size . " polzades</p>";
   }
}
```

## Bibliografia

  - José Luis Comesaña.  *Apuntes de formación a distancia del módulo
    «Desarrollo web en entorno servidor» del CFGS DAW, elaborados y
    licenciados por el Ministerio de Educación, Cultura y Deporte.* \[en
    línia]. 2012 [data de consulta: 13 de setembre de 2019].
    Disponible en
    <<https://github.com/statickidz/TemarioDAW/tree/master/DWES>>
  - Antonio López. *Learning PHP 7.* Packt Publishing (29 de marzo de
    2016).
  - Janssen, Thorben. «OOP Concept for Beginners: What Is Encapsulation». Stackify, 7 gener 2022, <https://stackify.com/oop-concept-for-beginners-what-is-encapsulation/> [data de consulta: 11 de setembre de 2022].  
  - Janssen, Thorben. «OOP Concept for Beginners: What Is Abstraction?» Stackify, 23 novembre 2017, <https://stackify.com/oop-concept-abstraction/> [data de consulta: 11 de setembre de 2022].
