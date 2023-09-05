
# Composer

## Introducció

Abans de tot cal definir què és un compoment o paquet en PHP. Un component PHP és un conjunt de codi **reutilitzable** que t’ajuda a solucionar un problema específic de la teua aplicació. Aquests components solen estar formats per diverses classes. **Composer** és una eina que permet gestionar components en PHP. 

Composer permet declarar els components dels que depèn el nostre projecte i gestionar-los (instal·lar/actualitzar). A diferència dels gestors de paquets com Apt o Yum, Composer gestiona els paquets per projecte, instal·lant-los en el directori (`vendor`) del projecte. 

Per defecte, no instal·la res de forma global. Per tant, és un gestor de dependències. Aquesta idea no és nova i Composer s’inspira fortament en npm de node i el bundler de ruby.

Composer ens soluciona dos problemes:
 
* **Gestionar les dependències amb llibreries de tercers.** Només cal que declarem les dependències i Composer s'encarregarà de descarregar i instal·lar tot el que siga necessari
* **_Autoloading_ del nostre codi.** Ja no haurem de fer més `require`, Composer ho farà per nosaltres

## Ús bàsic

Composer manté la seua configuració en dos fitxers: `composer.json` i `composer.lock`.

Per usar Composer el primer que necessitem és disposar de l’arxiu `composer.json`. En aquest fitxer existeixen un seguit
d'estructures d'informació:

```json
{
    "require": {
        "monolog/monolog": "2.0.*"
    }
}

```

`require` indica els paquets que requerix la aplicació i els mapeja (en l’exemple, `monolog/monolog`) a la versió requerida (en aquest cas: `2.0.*`).

Si necessitàrem usar en un projecte el component `monolog` executariem en la carpeta del projecte:

```shell
composer require monolog/monolog
```

Com hauràs observat el nom del paquet està format per dues parts:

* La primera indica qui és el seu "vendor" o creador.
* La segona indica el nom del projecte.

```shell
composer require vendor/package
```
Sovint les dues parts són idèntiques.

El fitxer `composer.lock` guarda la versió exacta que s'ha instal·lat de cada paquet. El projecte es fixa a unes determinades versions. Tant el `composer.lock` com el `composer.json` han d'estar al repositori.

### Limitar la versió dels paquets

En alguns casos és necessari limitar les versions dels paquetes per mantindre compatibilitat. Hi ha diverses formes d'expressar dites limitacions:

* Restricció de la versió exacta
    * Exemple: 1.0.2  #MAJOR.MINOR.PATCH.
* Rang de versions
    * Exemples:
      * `>=1.0`
      * `>=1.0 <2.0`
      * `>=1.0 <1.1` || `>=1.2`
* Rang de versions comodins (.*)
    * Es pot especificar una patró en un  * comodí. `1.0.*` és l'equivalent de `>=1.0 <1.1`.
    * Exemple: `1.0.*`
* Rang amb tilde  (~)
    * L'operador `~`  s'explica millor en un exemple: 
        `~1.2` és equivalent a `>=1.2 <2.0.0`, mentre que `~1.2.3` és equivalent a `>=1.2.3 <1.3.0`. 
    * Exemple: `~1.2`
* Rang de versió amb cimcurflex (`^`)
    * Per exemple `^1.2.3` és equivalent a `>=1.2.3 <2.0.0` ja que ninguna de les _releases_ fins a la `2.0` deuria trencar compatibilitat en versions anteriors. 
    * Exemple: `^1.2.3`

## Versionat semàntic (semver)
Els números de versió i la forma en que canvien informen sobre el que va ser modificat d'una versió a una altra.

Veure l'especificació en el següent document:
[http://semver.org/lang/es/](http://semver.org/lang/es/)

## Instal·lant dependències

L’ordre `install` comprova primer si existeix el fitxer `composer.lock`, i si existeix, descàrrega exactament les versions que s'indiquen en aquest l'arxiu `composer.lock`.

Si treballem en equip, tot l'equip tindrà les mateixes versions.

Executem la següent ordre:

```shell
composer install
```
Es generarà el directori `vendor/` amb les llibreries de les quals depèn el projecte.

!!! warning "directori `vendor`"
    Hem d'afegir el directori `vendor/` a l'arxiu `.gitignore`, perquè crea gran quantitat de fitxers que després s'han de descarregar amb `composer install`.

L’ordre també crea un fitxer `composer.lock`

## Actualitzar versions

Si tenim l'arxiu `composer.lock` sempre s'instal·laran les mateixes versions dels paquets.

Per actualitzar a noves versions, fem servir l’ordre `composer update`. Aquesta ordre fa que Composer busque les versions més recents de les llibreries sempre que segueixin complint les restriccions de les versions indicades a l'arxiu `composer.json`. També actualitza l'arxiu `composer.lock`.

Si només volem instal·lar o actualitzar una dependència, podem indicar el seu nom després de l’ordre:

```shell
composer update monolog/monolog
```

!!! danger "No actualitzar en producció"
    Quan desplegues una aplicació basada en Composer a producció, usa sempre `composer install`. No haurieu d'usar mai `composer update` ja que podria ser que s'actualitzara algun paquet a una versió no provada. 


## Afegint dependències

L’ordre que afegeix noves dependències en el arxiu `composer.json`:

```shell
composer require
```

Ens preguntarà quines llibreries volem afegir.

Després d'afegir aquestes noves dependències, s’instal·len o actualitzen les dependències que siguen necessàries.
Podem passar les noves dependències com argument de l'ordre.

```shell
composer require monolog/monolog:
```
## Packagist

Packagist és el repositori central de paquets que pot gestionar Composer.

Lloc Web: http://packagist.org

## Carrega automàtica de classes

Normalment les llibreries proporcionen informació sobre la càrrega automàtica de les seves classes. Composer genera un arxiu `vendor/autoload.php`.

Incloent aquest fitxer en el projecte, podem utilitzar qualsevol classe instal·lada a través de Composer sense haver de incloure-la  explícitament:

```php
require 'vendor/autoload.php';
```

En el nostre cas, afegirem el `require` anterior en el fitxer `bootsrap.php`.

!!! important "`vendor/autoload.php`"
    `autoload.php` és el punt d'entrada de l'aplicació a totes les funcionalitats que ens oferix **Composer**.

### Classes personalitzades
Podem emprar l’_autoloader_ de Composer per a carregar les nostres classes. Si el nostre _namespace_ és `App` i els arxius estan en `src` afegirem:

```json
    "autoload": {
        "psr-4": { "App\\": "src/" }
    }
```

Després executarem `composer dump-autoload` perquè és regenere `vendor/autoload.php`.

!!! important "PSR-4"
    PSR-4 (_PHP Standard Recommendation_) és una de les recomanacions del PHP-FIG per a implementar el sistema de càrrega automàtica de classes. PHP-FIG (_Framework Interoperability Group_). La idea del grup és que els representants del projecte parlen sobre els punts en comú entre els seus projectes i troben maneres de treballar junts.

