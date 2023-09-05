# Espais de noms (_namespaces_)

En el món de PHP, els espais de noms estan dissenyats per a solucionar dos problemes amb què es troben els autors de biblioteques i d'aplicacions en crear elements de codi reusable, com ara classes o funcions:

* El conflicte de noms entre el codi que es crea i les classes/funcions/constants internes de PHP o les classes/funcions/constants de tercers.
* La capacitat de sobrenomenar (o abreujar) `Noms_Extra_Llargs` dissenyada per alleugerir el primer problema, millorant la llegibilitat del codi font.

Els espais de noms de PHP proporcionen una manera per agrupar classes, interfícies, funcions i constants relacionades. 

En la seva definició més acceptada, els espais de noms són una manera d'encapsular elements.
Exemple: directoris en els sistemes de fitxers.

El fitxer `foo.txt` pot existir en els directoris `/home/Greg` i `/home/altre`, però no poden coexistir dues còpies de `foo.txt` en el mateix directori.

A més, per accedir al fitxer `foo.txt` fora de directori `/home/Greg`, s'ha d'avantposar el nom de directori al nom del fitxer, emprant el separador de directoris per així obtenir `/home/greg/foo.txt`. 

Aquest mateix principi s'estén als espais de noms en el món de la programació.

### Definir _namespaces_

### Usar _namespaces_

### Namespaces alias

### _Namespaces_ i _autoloading_

Per a entendre la relació entre els espais de noms i la càrrega automàtica de classes res millor que anar a la font original: [PSR-4 Autoloader](https://www.php-fig.org/psr/psr-4/)

