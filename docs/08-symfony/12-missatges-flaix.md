# Missatges flaix

Els missatges flaix ja el coneixes, en Symfony, funcionen de la mateixa forma, s'escriuen 
en una variable de sessió i una vegada són llegits en la pàgina de destí desapareixen.

Per exemple:

```php
   $this->addFlash(
            'success',
            'Your changes were saved!'
        );
```
El primer paràmetre pots qualsevol nom. En el nostre cas, com que usem
_bootstrap_ és convenient que la etiqueta coincidisca amb les classes preestarblertes:
`success`, `danger`,`warning`, `info`, etc.

## Canvis en la plantilla ase

Per a integrar-los en la plantilla base pots usar aquest codi:

{% raw %}
```twig
 {# read and display all flash messages #}
    {% for label, messages in app.flashes %}
        {% for message in messages %}
            <div class="alert alert-{{ label }} alert-dismissible fade show" role="alert">
                {{ message }}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        {% endfor %}
    {% endfor %}
```
{% endraw %}

Com es pot observar la variable `label`, serà la determinarà la classe que s'aplicarà.

Més informació en [Flash Messages](https://symfony.com/doc/current/controller.html#id2)

## Paràmeters globals

Com ja hem vist en les sessions introductòries podem crear paràmetres
globlals per poder-los usar des de qualsevol lloc de l'aplicació.

Anem a aplicar-ho al directori on es guarden els posters. Definirem un paràmetre
`posters_directory` que indicarà quin és el directori.

```yaml
parameters:
    posters_directory: '%kernel.project_dir%/public/images/posters'
```

La variable d'entorn `%kernel.project_dir%` representa el directori on tenim
el nostre projecte Symfony. 

Ara modificarem el controlador perquè agafe la ruta del paràmetre:

```php
   ...
    try {
        $postersDir = $this->getParameter('posters_directory');
        $posterFile->move($postersDir, $filename);
        $movie->setPoster($filename);
    } catch (FileException $e) {
    ...

```
També podem crear paràmetres globals per a usar-los en les plantilles de Twig. Per exemple,
per a indicar la ruta pública dels pòsters:

```yaml
# config/packages/twig.yaml
twig:
    ...
    globals:
        posters_public_directory: 'images/posters/'
```

I l'usariem així:


```html+twig
<img class="card-img-top" src="{{ asset(posters_public_directory ~  movie.poster) }}" 
    title="{{ movie.title }}"></a>
```