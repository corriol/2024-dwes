# Gestió de fitxers CSS i Javascript amb Webpack Encore

**Webpack** és una eina d'empaquetador de mòduls per a aplicacions web. Ajuda a agrupar i optimitzar els fitxers JavaScript, CSS, 
imatges i altres recursos per a la seva distribució als navegadors web. A més, proporciona característiques com la 
*gestió de dependències* i el muntatge de mòduls, així com la capacitat de crear diversos paquets per a diferents entorns.

**Encore** és una eina de configuració de Webpack i un empaquetador d'aplicacions JavaScript per a Symfony. Proporciona 
una forma fàcil i convenient d'utilitzar **Webpack** i gestionar recursos com fulls d'estil, JavaScript i imatges 
en els projectes Symfony. Encore també permet la integració d'eines com Babel, Sass i TypeScript, i inclou funcions 
com la divisió de codi i importacions dinàmiques.

En aquest capítol integrarem i optimitzarem un full d'estils personalitzat, _Bootstrap 5_ i _Bootstrap Icons_.

## Pas 1: Instal·lació de Node.js 

Per començar, hauràs d'instal·lar Node.js i un gestor de dependències com `yarn` o `npm`. Nosaltres usarem el darrer.

En [Download | Node.js](https://nodejs.org/en/download/) trobaràs les diferents opcions d'instal·lació de Node.js. En cas d'usar una versió basada en 
Linux els repositoris els pots trobar en [Nodesource](https://github.com/nodesource/distributions/blob/master/README.md#debinstall)

En el projecte treballarem en la versió de Node.js 18 ja que és la darrera versió de suport a llarg termini (LTS).

## Pas 2: Instal·lació Webpack Encore Bundle

Per a instal·lar Encore cal executar:

```sh
composer require symfony/webpack-encore-bundle
```

Després executarem el següent comandament perquè s'instal·len els mòduls necessaris: 

```sh
npm install
``` 
I finalment `npm run dev` per poder realitzar la compilació.

## Pas 3: Revisió dels fitxers de configuració de Webpack

Després d'instal·lar Webpack Encore s'hauran creat la carpeta `assets` i el fitxer de configuració de Webpack `webpack.config.js` a l'arrel del teu projecte Symfony. Aquest fitxer contindrà totes les opcions de configuració de Webpack Encore.

```javascript
const Encore = require('@symfony/webpack-encore');

Encore
    // el directori del projecte on s'emmagatzemaran tots els actius compilats
    .setOutputPath('public/build/')

    // la ruta pública utilitzada pel servidor web per accedir al directori anterior
    .setPublicPath('/build')

    /* Entrades
     * Cada entrada generarà un fitxer Javascript i un fitxer CSS si
     * el Javascript importa CSS.
     */
    .addEntry('app', './assets/js/app.js')


    // enables the Symfony UX Stimulus bridge (used in assets/bootstrap.js)
    .enableStimulusBridge('./assets/controllers.json')

    // When enabled, Webpack "splits" your files into smaller pieces for greater optimization.
    .splitEntryChunks()

    // will require an extra script tag for runtime.js
    // but, you probably want this, unless you're building a single-page app
    .enableSingleRuntimeChunk()

    /*
     * FEATURE CONFIG
     *
     * Enable & configure other features below. For a full
     * list of features, see:
     * https://symfony.com/doc/current/frontend.html#adding-more-features
     */
    
    .cleanupOutputBeforeBuild()
    .enableBuildNotifications()
    .enableSourceMaps(!Encore.isProduction())
    // enables hashed filenames (e.g. app.abc123.css)
    .enableVersioning(Encore.isProduction())

    // configure Babel
    // .configureBabel((config) => {
    //     config.plugins.push('@babel/a-babel-plugin');
    // })

    // enables and configure @babel/preset-env polyfills
    .configureBabelPresetEnv((config) => {
        config.useBuiltIns = 'usage';
        config.corejs = '3.23';
    })

    // enables Sass/SCSS support
    //.enableSassLoader()

    // uncomment if you use TypeScript
    //.enableTypeScriptLoader()

    // uncomment if you use React
    //.enableReactPreset()

    // uncomment to get integrity="..." attributes on your script & link tags
    // requires WebpackEncoreBundle 1.4 or higher
    //.enableIntegrityHashes(Encore.isProduction())

    // permet a les aplicacions antigues utilitzar $/jQuery com a variable global
    //.autoProvidejQuery()
;

module.exports = Encore.getWebpackConfig();
```

El fitxer `/assets/app.js` és un recurs que inicialment integra un full
d'estils i _Stimulus_ un framework Javascript lleuger dels creadors de Symfony.

```javascript
import './styles/app.css';

// start the Stimulus application
import './bootstrap';
```
Cal destacar que per integrar el fitxer de recursos cal que disposar
d'una entrada associada a `webpack.config.js`. En aquest cas:

```javascript
.addEntry('app', './assets/js/app.js')
```

El primer paràmetre, `app` en l'exemple, identifica el fitxer de recursos.

## Pas 4: Compilació dels recursos

Ara pots compilar els teus recursos utilitzant el següent comandament:

```sh
npm run dev-server
```

Aquest comandament compilarà els teus actius i els guardarà al
directori especificat en el fitxer de configuració. A més a més, executarà un servidor de desenvolupament que vigilarà els teus arxius i actualitzarà automàticament els actius compilats cada vegada que facis canvis.

Hi ha d'altres que pots consultar en [Configuring Encore/Webpack](https://symfony.com/doc/current/frontend/encore/simple-example.html#configuring-encore-webpack).

## Pas 5: Inclusió dels recursos compilats en les teues plantilles

Per utilitzar els recursos compilats en les teves plantilles, hauràs de fer referència a ells utilitzant les següents funcions de Twig que s'inclouen en la plantilla per defecte:

```html hl_lines="8 15"
<!DOCTYPE html>
<html>
    <head>
        <!-- ... -->

        {% block stylesheets %}
            {# 'app' must match the first argument to addEntry() in webpack.config.js #}
            {{ encore_entry_link_tags('app') }}

            <!-- Renders a link tag (if your module requires any CSS)
                 <link rel="stylesheet" href="/build/app.css"> -->
        {% endblock %}

        {% block javascripts %}
            {{ encore_entry_script_tags('app') }}

            <!-- Renders app.js & a webpack runtime.js file
                <script src="/build/runtime.js" defer></script>
                <script src="/build/app.js" defer></script>
                See note below about the "defer" attribute -->
        {% endblock %}
    </head>

    <!-- ... -->
</html>
```

!!! Important
    Fixa't que el paràmetre que passem a les funcions `encore_entry...` és `app`, l'identificador que hem assignat prèviament al fitxer de recursos.

## Pas 6: Integració de Bootstrap i Bootstrap Icons

Primerament instal·larem els dos mòduls: 

```sh
npm install bootstrap --save-dev
npm install bootstrap-icons --save-dev
```

Després caldrà afegir-los en el fitxer de recursos `app.js`. Tin en compte 
que el directori de referència serà `node_modules`.

```javascript
// /assets/app.js
import './styles/app.css';

// CSS de Bootstrap
import 'bootstrap/dist/css/bootstrap.css';

// CSS de Bootstrap Icons
import 'bootstrap-icons/font/bootstrap-icons.css';

// Javascript de Bootstrap
import 'bootstrap/dist/js/bootstrap';

// start the Stimulus application
import './bootstrap';
```
En compilar tindrem automàticament els dos mòduls disponibles en l'aplicació web.

## Recursos addicionals

- https://webpack.js.org/
- https://symfony.com/doc/5.4/frontend/encore/installation.html
- https://symfony.com/doc/current/frontend/encore/simple-example.html
- https://www.npmjs.com/

