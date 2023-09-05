# Composer. Introducció al _testing_

??? info "Objectius"
    * Gestionar dependències amb llibreries de tercers.
    * Utilitzar el autoloading de Composer en el nostre projecte.
    * Utilitzar llibreries de tercers: Monolog, WebMozart.
    * Realitzar test unitaris
   

??? info "Continguts"
    1. Instalación de Composer
      a) Packagist
      b) Semantic Versioning
    2. Uso de librerías de terceros
      a) Monolog
    3. Namespaces
    4. Introducció al _testing_. Refactoring


??? info "Criteris d'avaluació"
    * RA09. A) S'han reconegut els avantatges que proporciona la reutilització de codi i l'aprofitament d'informació ja existent.
    * RA09. B) S'han identificat llibreries de codi i tecnologies aplicables en la creació d'aplicacions web híbrides.
    * RA09. E) S'han utilitzat llibreries de codi per a incorporar funcionalitats específiques a una aplicació web

## Introducció

Fins ara hem aprés a usar les diferents funcionalitats de PHP d'una forma molt bàsica. 
Ara anem a introduir una sèrie de ferraments i conceptes que ens ajudaran a realitzar 
les aplicacions d'una forma més àgil i segura.

!!! more "Refacció"
    En enginyeria del programari, el terme refacció, en anglès _refactoring_, s'empra per a descriure el fet de modificar codi font sense canviar-ne el comportament observat des de l'exterior. La refacció sovint és una part del cicle de vida del programari: els desenvolupadors alternen entre la producció de noves funcionalitats i la refacció de codi ja existent per tal de millorar-ne la consistència interna i la claredat. Les proves de regressió asseguren que la refacció no ha canviat el comportament del codi observat des d'altres mòduls del programa. 


## Patrons de disseny 

Segons Viquipèdia: 

  > En enginyeria de programari, un patró de disseny és una solució general a un problema comú i recurrent en el disseny de programari. Un patró de disseny no és un disseny acabat que es pot transformar directament en codi; és una descripció o plantilla per resoldre un problema que es pot utilitzar en moltes situacions diferents. 

És a dir, són solucions als problemes habituals que podem trobar-nos en desenvolupar el nostre programari.

Hi ha molts patrons de disseny com podeu trobar en les següents pàgines:

  * [Refactoring guru](https://refactoring.guru/design-patterns)
  * [Design Patters PHP](https://designpatternsphp.readthedocs.io/en/latest/README.html)

En el nostre cas en vorem alguns senzills, fàcils d'aplicar i que després trobarem en els framewoks més habituals.

### Registry

El propòsit del patró `Registry` és implementar un emmagatzematge central per als objectes que s'utilitzen sovint a tota l'aplicació, normalment s'implementa utilitzant una classe abstracta amb només mètodes estàtics (o utilitzant el patró `Singleton`). 

!!! warning "Estat global"
    El patró `Registry`  introdueix un estat global, és a dir, crea un objecte d'àmbit global, la qual cosa s'hauri d'evitar tot moment!

No obstant això, en projectes xicotets i senzills pot utilitzar-se perfectament. Més avant del patró `Dependency Injection`
que seria el recomanat en aquestos casos.

En [Registry](https://designpatternsphp.readthedocs.io/en/latest/Structural/Registry/README.html) teniu un exemple d'implementació.

### Adapter/Wrapper

El propòsit és traduir una interfície d'una classe a una interfície compatible. Un adaptador permet que les classes treballen juntes ja que normalment no podrien ja que tenen interfícies incompatibles proporcionant la seua interfície als clients mentre s'utilitza la interfície original.

Teniu més informació en [Adapter/Wrapper](https://designpatternsphp.readthedocs.io/en/latest/Structural/Adapter/README.html) i en
[Adapter in PHP](https://refactoring.guru/design-patterns/adapter/php/example#example-0)


### DataMapper

Un _DataMapper_, és una capa d'accés a dades que realitza la transferència bidireccional de dades entre un magatzem de dades persistent (sovint una base de dades relacional) i una representació de dades en memòria (la capa de domini). L'objectiu del patró és mantenir la representació a la memòria i el magatzem de dades persistent independents entre sí i del propi mapejador de dades. La capa està formada per un o més mapeadors (o objectes d'accés a dades), que realitzen la transferència de dades. Les implementacions de _mapper_ varien. Els mapeadors genèrics gestionaran molts tipus d'entitats de domini diferents, els mapejadors dedicats en gestionaran un o alguns.

Més detalls en [https://designpatternsphp.readthedocs.io/en/latest/Structural/DataMapper/README.html](https://designpatternsphp.readthedocs.io/en/latest/Structural/DataMapper/README.html)

### Repository

Media entre el domini i les capes de mapatge de dades mitjançant una interfície semblant a una col·lecció per accedir als objectes del domini. El repositori encapsula el conjunt d'objectes que persisteixen en un magatzem de dades i les operacions que s'hi duen a terme, proporcionant una visió més orientada a objectes de la capa de persistència. El repositori també admet l'objectiu d'aconseguir una separació neta i una dependència unidireccional entre el domini i les capes de mapatge de dades. 

Més detalls en [https://designpatternsphp.readthedocs.io/en/latest/More/Repository/README.html](https://designpatternsphp.readthedocs.io/en/latest/More/Repository/README.html).
