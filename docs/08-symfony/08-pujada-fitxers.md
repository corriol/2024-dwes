
# Pujada de fitxers

## Introducció

El que recomana Symfony és treballar en el component [VichUploader](https://github.com/dustin10/VichUploaderBundle)

## Redimensionar imatges

Per a redimensionar les imatges podem usar el component [LiipImagineBundle](https://symfony.com/doc/2.0/bundles/LiipImagineBundle/index.html).

Seguint el següent tutorial: [Basic Usage](https://symfony.com/doc/2.0/bundles/LiipImagineBundle/basic-usage.html) crearem el grup de filtres `my_thumb` que realitza una miniatura de la imatge afegint-li una vora de color negre.

El funcionament és senzill:

1. Es crea un un grup de filtres, `my_thumb`, en l'exemple, on s'indiquen els filtres que s'aplicaran, `thumbnail` i `background` en l'exemple.
2. Després s'utilitza el filtre en les plantilles de Twig:


```html+twig
<img src="{{ asset('/relative/path/to/image.jpg') | imagine_filter('my_thumb') }}" /> 
```

Combinant-ho amb `VichUploader` la plantilla quedaria així:

```html+twig
<img  src="{{ vich_uploader_asset(link, 'imageFile') | imagine_filter('my_thumb') }}" 
    alt="{{ link.title }}" />
```


En els formularis on s'usa VichUploader s'aplica de la següent forma:

```php
    ->add('imageFile', VichImageType::class, [
        'required' => false,
        'allow_delete' => true,
        'asset_helper' => true,
        'imagine_pattern' => 'my_thumb']);
```

El que fa `LiipImagine` és crear en un directori temporal els resultats d'aplicar els filtres.