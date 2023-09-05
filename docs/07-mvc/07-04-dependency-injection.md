# La injecció de dependències

La injecció de dependències (_dependency injection_) és un patró de disseny orientat a objectes en
 què es subministren els objectes a una classe en lloc de ser la mateixa classe la que crea
  aquests objectes. 

Aquests objectes compleixen contractes (interfícies, classes abstractes) que necessiten les nostres
 classes per poder funcionar (d'aquí el concepte de dependència). 

Les nostres classes no creen els objectes que necessiten, sinó que se'ls subministra una altra 
classe 'contenidora' que injectarà la implementació desitjada al nostre contracte.

Simplificant:

> La injecció de dependències proporciona a una classe les seves dependències ja siga mitjançant 
  la injecció del constructor, crides a mètodes o l’establiment de propietats.

Exemple:
<https://github.com/Seldaek/monolog/blob/master/doc/01-usage.md>

## Contenidor de serveis

El contenidor de serveis és una utilitat que ajuda a la implementació de la injecció de dependències. 
S'encarrega de registrar totes les depedències (objectes) de l'aplicació. L'aplicació web les extraurà i 
injectarà quan les necessite. Es tracta d'una estructura de dades semblant al `Registry`.


## Autowiring

_Autowiring_ és una palabra exótica que representa una cosa molt senzilla: la capacitat del contenidor per a crear i 
injectar dependències automàticament.

La idea bàsica és que quan es cride un mètode d'una classe, si s'ha indicat el tipus de dada de l'argument en la 
declaració del mètode, el contenidor busque una instància d'eixa classe i 
la injecte automàticament. 

Per exemple:

```php
class DatabaseConnection
{
    // ...
}

class MovieModel
{
    public function __construct(DatabaseConnection $DBconnection)
    {
        // ...
    }
}
```

Quan el contenidor necessite crear un objecte `MovieModel`, detectarà que aquesta classe necessita un objecte 
`DatabaseConnection`, el buscarà en el contenidor i l'injectarà automàticament.

Aquesta és una funcionalitat molt important en els _frameworks_ PHP moderns.

Més informació:
* [https://php-di.org/doc/autowiring.html](https://php-di.org/doc/autowiring.html)