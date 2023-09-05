# Ús del paquet Monolog

Per utilitzar la llibreria Monolog podem usar les seves classes i Composer s'encarregarà de carregar-les:

```php
$log = new Monolog\Logger('name');
$log-> pushHandler (
    new Monolog\Handler\StreamHandler('app.log', Monolog\Logger::INFO)
);
$log→info('Foo');
```
Més informació:
https://packagist.org/packages/monolog/monolog
https://github.com/Seldaek/monolog/blob/HEAD/doc/01-usage.md