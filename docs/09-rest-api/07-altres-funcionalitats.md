# Altres funcionalitats

## Control del temps de vida del _token_
## Paginació
## Seguiment dels canvis
En molts sistemes, en modificar qualsevol objecte, queda registrat qui i quan s'ha realitzat dit canvi.

En Symfony, es pot implementar fent ús d'algunes extensions de Doctrine:

- `Blameable` - updates string or reference fields on create, update and even property change with a string or object (e.g. user).
- `Timestampable` - updates date fields on create, update and even property change.

More info at: [Doctrine Extensions](https://github.com/doctrine-extensions/DoctrineExtensions)

## Més enllà del CRUD

## Gestió d'imatges

Bàsicament hi ha dues formes de fer-ho: la primera d'elles seria usant un formulari multi-part com fem en les aplicacions web tradicionals, la segona usant l'estil API, és a dir, enviant la imatge amb JSON gràcies a base64_decode que perment serialitzar les imatges a _string_ per poder enviar-les en la sol·licitud. Ens centrarem en aquesta opció.


<https://symfonycasts.com/screencast/symfony-uploads/api-uploads>
<https://api-platform.com/docs/core/file-upload/>

