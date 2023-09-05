# Els bundles de Symfony


## Introducció

Els bundles en Symfony són elements coneguts com a mòduls o plugins en
altres frameworks. Es defineixen en l'arxiu config/bundles.php per a
cada entorn (desenvolupament, producció, etc), de manera que poden
activar-se només per a certs entorns.

L'exemple més habitual de bundle específic per a un entorn és el bundle
profiler, que s'encarrega de mostrar la finestra d'error i depuració
cada vegada que es produeix un error en l'aplicació, mostrant el
missatge i traça de l'error, usuari autenticat i altres dades que no
són recomanables en un entorn de producció. Aquest bundle només està
habilitat per a l'entorn de desenvolupament i proves, però no per a
producció.

### Bundles preinstal·lats

Si tirem la vista arrere, a la primera sessió del curs, vam veure que
existien dues formes de crear un projecte Symfony:

```php
composer create-project symfony/website-skeleton project-name

composer create-project symfony/skeleton project-name
```

La primera d'elles és la que hem usat fins ara, i deixa preinstalado un
conjunt de bundles útils per a desenvolupar una aplicació web amb
Symfony. Entre ells està el motor de plantilles Twig, l'ORM Doctrine i
uns altres.

Si optem per crear un projecte mitjançant la segona opció, obtindrem un
projecte sense (quasi) cap funcionalitat afegida. Aquesta forma de
definir projectes s'ha habilitat des de Symfony 4 per a donar cabuda a
projectes més lleugers, on només s'instal·le el necessari. No obstant
açò, com ja comentem abans, s'ha deixat disponible l'altra alternativa
per a desenvolupar projectes de forma còmoda, amb moltes funcionalitats
preinstaladas, encara que realment algunes no les anem a utilitzar.

En qualsevol cas, convé tenir present que totes aqueixes funcionalitats
preinstaladas en el nostre projecte, i moltes altres que podem requerir,
són bundles o plugins externs al nucli de Symfony.

En aquesta sessió veurem com afegir aquests bundles als projectes, i
parlarem d'alguns bundles interessants a més dels quals ja hem vist.

## Instal·lació de bundles

Anem a provar a crear un projecte bàsic sense esquelet web. Per exemple,
veu a la teua carpeta de treball (/home/alumne/symfony) i crea aquest
projecte:

composer create-project symfony/skeleton prova_bundles

Si fas una ullada a l'estructura del projecte, veuràs que en la carpeta
vendor amb prou faenes té un parell d'elements, mentre que aqueixa
mateixa carpeta en l'aplicació de contactes o llibres que hem vingut
fent té molts més.

Anem a fer ara el mateix que vam fer quan vam crear els projectes de
contactes i llibres: configurar Apatxe per a poder accedir al projecte
mitjançant un virtual host. Recordem els passos:

1.  Edita l'arxiu /etc/hosts (amb permisos de root) per a afegir un nou
    domini local per a la nostra aplicació. Cridarem a aquest domini
    symfony.bundles: 127.0.0.1 symfony.bundles
2.  Ja tindrem un parell de passos fets de projectes previs: configurar
    la carpeta /home/alumne/symfony amb els permisos d'accés necessaris
    per als projectes que tindrem dins, i habilitar la creació d'hosts
    virtuals en Apatxe. Així que aquests passos podem saltar-los ara
3.  Edita l'arxiu /opt/lampp/etc/extra/httpd­vhosts.conf i afig un nou
    host virtual per a la nostra aplicació. Haurà de quedar-te així:
    \<VirtualHost \*:80\> DocumentRoot
    "/home/alumne/symfony/prova_bundles/public" ServerName
    symfony.bundles
4.  Reinicia el servidor Apatxe, i intenta accedir a
    http://symfony.bundles, per a veure la pàgina d'inici.

###. Exemple: Doctrine

Anem a fer una prova per a treballar amb Doctrine en el nostre nou
projecte. Per a començar, anem a crear una base de dades anomenada
peliculas per a emmagatzemar certa informació bàsica de pel·lícules. Per
a crear la base de dades, editem l'arxiu .env del projecte i definim la
URL de connexió a la base de dades, com hem fet per als projectes
anteriors:

```
DATABASE_URL=mysql://root\@127.0.0.1:3306/peliculas
```
i després, vam crear la base de dades amb el comando:

```
php bin/console doctrine:database:create
```

El que obtindrem en executar aquest comando és un missatge d'error en
la consola que indica que no troba el comando. Necessitem instal·lar el
bundle Doctrine per a solucionar el problema. En realitat, instal·larem
un bundle anomenat orm­pack, que conté a Doctrine, juntament amb el
bundle maker que és el que permet generar cert codi automàticament, com
per exemple les entitats. Per a açò, escrivim aquests comandos des de la
carpeta principal del projecte:

```shell
composer require symfony/orm-pack

composer require symfony/maker-bundle --dev
```

Després d'aquests passos, editem l'arxiu `.env` novament, i definim la
URL de connexió a la base de dades (és possible que s'haja duplicat amb
aquesta instal·lació). Després, tornem a intentar crear la base de
dades, i tot funcionarà correctament.

Intentem ara crear una entitat. En aquest cas, anem a crear una entitat
anomenada Pelicula, amb un aneu autogenerado, un títol (string) i un
any.

```shell
php bin/console make:entity

Class name of the entity to create or update (i.g. OrangePizza):

Pelicula

New property name (press to stop adding fields):
>titule

Field type (enter? to see all types) [string]:

string

Field length [255]:
>255

Can this field be null in the database (nullable) (yes/no) \[no\]:
>no

Add another property? Enter the property name (or press to stop adding
fields):
>anyo

Field type (enter? to see all types) [string]:
>integer

Can this field be null in the database (nullable) (yes/no) \[no\]:
>no

Add another property? Enter the property name (or press to stop adding
fields):

Success!

A continuació, migramos els canvis a la base de dades:

```shell
php bin/console make:migration

php bin/console doctrine:migration:migrate
```
Ja tenim la base de dades creada, amb la seua taula pelicula. Podem
inserir ara un parell de pel·lícules de prova, a mà des de phpMyAdmin:

Definim ara un controlador que cerque totes les pel·lícules i les mostre
en la pàgina. Creem una classe PeliculaController en la carpeta
src/Controller, amb un codi com a est:

```php
getDoctrine()-\>getRepository(Pelicula::class); \$peliculas =
\$repositori-\>findAll();

if (count(\$peliculas) \> 0 ) { \$resultat = \"\"; foreach(\$peliculas
as \$pelicula) \$resultat .= \$pelicula-\>getTitulo(). \" (".
\$pelicula-\>getAnyo(). \")\<br /\>\"; return new Response(\$resultat);
} else { return new Response("No s'han trobat pel·lícules\"); } } }

?\>
```

Abans de comprovar el funcionament, recorda configurar la reescriptura
de rutes en l'aplicació, escrivint aquests comandos des de la carpeta
principal del projecte:

```shell
composer config extra.symfony.allow-contrib true
composer req symfony/apache-pack
```

Després ja podrem accedir a movies-symfony/peliculas i veure el llistat
en pantalla:

En aquest punt, pots realitzar l'Exercici 1 dels proposats al final de
la sessió.

### Instal·lació d'altres bundles coneguts

Al llarg d'aquestes sessions de curs hem estat utilitzant certs bundles
de Symfony que també necessiten ser instal·lats (es van instal·lar
automàticament a través del website­skeleton, i per açò no ens hem
percatado). Fem un repàs:

-   Per a poder utilitzar **anotacions** (com l'anotació \@Route que
    emprem per a definir les rutes de l'aplicació), necessitem
    instal·lar el bundle annotations. Aquest bundle és dels pocs que
    s'instal·len en el skeleton b ásico de Symfony. Encara així, per a
    instal·lar-ho manualment si fóra el cas, hauríem d'executar el
    comando: composer require annotations
-   Per a poder emprar el gestor de **formularis** de Symfony, i
    crear-los i validar-los mitjançant codi, hem d'instal·lar els
    bundles forms i validator, respectivament, d'aquesta manera:
    composer require symfony/form composer require symfony/validator
-   Per a aplicar la infraestructura de **seguretat** de Symfony en la
    nostra aplicació, i poder definir rols, rutes protegides, etc,
    necessitarem instal·lar el bundle security, as í: composer require
    symfony/security-bundle
-   Per a poder disposar del motor de plantilles **Twig** , necessitarem
    instal·lar-ho també: composer require twig-bundle

Com diem, tots aquests bundles es preinstalan en crear el projecte a
partir del website­skeleton, però no estan disponibles (excepte les
anotacions), si ho vam crear a partir del skeleton b ásico. En una
secció posterior veurem altres bundles addicionals que puguen
resultar-nos útils, a més d'aquests que ja hem vingut usant.

### Més bundles interessants

Ara que ja sabem com crear un projecte quasi buit en Symfony i
instal·lar manualment els bundles que necessitem, vegem alguns bundles
addicionals que poden resultar útils, a més dels quals hem comentat ja,
i vingut usant en sessions prèvies (Twig, Doctrine, seguretat...).

Existeixen diferents webs on poder obtenir informació d'aquests
bundles:

-   packagist.org, un repositori de paquets PHP en general, entre els
    quals podem trobar nombrosos bundles de Symfony, molts d'ells
    desenvolupats pel propi equip de Symfony, entre els quals
    s'inclouen els ja vistos (orm­pack, validator, twig­bundle, etc).
-   knpbundles.com, una web mantinguda per la companyia KNP, que és una
    de les quals més suport donen a Symfony quant a bundles es refereix.
    En ella trobarem tant bundles desenvolupats per aquesta companyia,
    com per unes altres, com per exemple FOS (FriendsOfSymfony), un grup
    de desenvolupament que va començar formant part de l'equip de KNP,
    però que després va decidir desenvolupar bundles sota un espai de
    noms propi.

#### Exemple: EasyAdmin

Vegem com instal·lar i treballar amb el bundle EasyAdmin. Aquest bundle
permet definir de forma automàtica un administrador per a gestionar les
entitats de la nostra aplicació. La seua instal·lació és molt senzilla,
a través d'aquest comando:

```shell
composer require admin
```

Després, hem d'editar l'arxiu config/packages/easy_admin.yaml que
s'haurà creat, i afegir les entitats que vulguem gestionar:

```yaml
easy_admin:

entities: \# List the entity class name you want to manage

-   App

```
I açò és tot. Accedint a la URI /admin en la nostra aplicació, podrem
gestionar les entitats indicades. Si seguim aquests passos en la nostra
aplicació symfony.bundles, i afegim l'entitat Pelicula com en
l'exemple anterior, podem accedir a symfony.bundles/admin i gestionar
aquesta taula i els seus elements:

Existeixen altres opcions de configuració del bundle, com per exemple
protegir l'accés amb contrasenya i altres opcions. Per a més
informació, podeu consultar la documentació oficial.

En aquest punt, pots realitzar l'Exercici 2 dels proposats al final de
la sessió.

### Exemple: Jens Segers Date

Aquest altre bundle permet treballar amb dates de forma senzilla,
convertint cadenes a dates amb un format determinat, establint locals
per a diferents localitzacions, fent càlculs entre dates, etc.

S'instal·la amb el següent comando:

```shell
composer require jenssegers/date
```

Després, n'hi ha prou amb utilitzar la classe Date per a accedir a
les seues propietats i mètodes. Per a provar el seu ús, crearem un nou
mètode en la nostra classe PeliculaController, associat a la ruta
/dates. Dins, crearem la data actual, que mostrarem amb un format
determinat per pantalla. També crearem una data a partir d'una cadena
de text, i calcularem la diferència entre aqueixa data i avui.

```php
use Jenssegers; ... /\*\* \* \@Route("/dates", name="dates") \*/ public
function dates() { Dóna't::setLocale('és'); \$avui = Dóna't::now();
\$naixement = Dóna't::createFromFormat('d/m/I', '7/4/1978');
\$diferencia = \$naixement-\>timespan();

return new Response('Avui és'. \$avui-\>format('d/m/I'). ''. 'Naixement
el'. \$naixement-\>format('d/m/i'). ''. 'Han passat:'. \$diferència);

}
```
L'eixida serà alguna cosa semblat a açò (variarà depenent de la data
actual):

Intenta realitzar l'Exercici 3 proposat al final de la sessió, de
caràcter opcional.

### Symfony Flex

Symfony Flex és una nova forma d'instal·lar i gestionar components en
projectes Symfony, disponible des de la seua versió 3.3. Ve a reemplaçar
a l'anterior instal·lador de Symfony, i al Symfony Standard Edition,
que, com comentem en la primera sessió del curs, suposava una
instal·lació molt més extensa i monolítica del framework.

Amb Symfony Flex s'automatitzen algunes tasques habituals, com
instal·lar o desinstal·lar bundles. De fet, des de Symfony 4 és el
mètode que s'empra per defecte per a aquestes instal·lacions (encara
que el seu ús segueix sent opcional), i ens evita haver d'editar a mà
l'arxiu config/bundles.php per a donar d'alta els nous bundles
instal·lats, o llevar els que ja no estiguem emprant. Per aquest motiu
hem pogut emprar Doctrine en un exemple anterior sense haver hagut de
tocar la configuració del projecte.

No entrarem en els detalls sobre els arxius de configuració i les dades
que empra Flex per a gestionar aquestes tasques, ja que no forma part
del nucli del curs, però sí considerem necessari que es conega la seua
existència per a saber per què s'autoconfiguran certes coses en els
projectes sense que hàgem d'intervenir.

2.5. Creació de bundles propis

A més d'instal·lar i utilitzar bundles de tercers, també podem elaborar
els nostres propis. De fet, fins a l'aparició de Symfony 4 es
recomanava que tota l'aplicació estiguera estructurada en bundles (és a
dir, que els propis components que desenvolupàrem per a l'aplicació
també anaren bundles), però a partir d'aquesta versió 4 ja no es
recomana aquesta estructura, i s'indica que els bundles s'empren per a
compartir codi entre múltiples aplicacions. En qualsevol cas, per a
crear el nostre bundle hem de seguir una estructura recomanada des de la
documentació oficial de Symfony.

La creació de bundles propis queda fora dels objectius principals del
curs, per la qual cosa no la veurem amb detall. A més, existeixen
multitud de bundles ja predefinits que permetran cobrir la immensa
majoria de les nostres necessitats. En qualsevol cas, ací teniu un punt
de partida que seguir per a saber més sobre aquest tema.

3. Exercicis

3.1. Exercici 1

Anem a crear un projecte similar al de proves que hem fet en el primer
exemple d'aquesta sessió. En aquest cas, anem a crear un projecte per a
gestionar tasques pendents. El comando de creació del projecte (des de
la nostra carpeta /home/alumne/ symfony) serà aquest:

composer create symfony/skeleton tasques

Després, segueix aquests passos:

1.  Fes que aquest nou projecte siga accessible des del domini
    symfony.tasques.
2.  Instal·la Doctrine (bundles orm­pack i maker, com s'ha fet en
    l'exemple anterior), i crea i connecta amb una base de dades
    anomenada tasques, editant l'arxiu .env per a açò.
3.  Crea una entitat anomenada Tasca amb aquests camps: ◦ Un aneu
    autogenerado ◦ La descripció de la tasca (string de 255 caràcters de
    longitud, sense nuls) ◦ La data de la tasca (tipus dóna't, sense
    nuls) ◦ La prioritat de la tasca (sencer, sense nuls) Actualitza la
    base de dades amb aquesta entitat, i crea a mà un parell de tasques
    en ella a través de phpMyAdmin. Procura que les prioritats tinguen
    valors entre 1 (ALTA) i 3 (BAIXA), ja que definirem aquest rang en
    la pròxima sessió.
4.  Crea un controlador en src/Controller anomenat TareaController.
    Defineix un mètode que, en carregar-se la URI /tasques mostre un
    llistat de les tasques en pantalla, sense un format específic.
    Recorda configurar la reescriptura de rutes perquè aquesta URI
    funcione.

NOTA : per a mostrar la data com a part d'una cadena, pots

utilitzar el mètode format del propi objecte DateTime:

\$tasca-\>getFecha()-\>format("d/m/I").

3.2. Exercici 2

Instal·la el bundle EasyAdmin, configura-ho per a treballar amb
l'entitat Tasca i crea amb ell unes quantes tasques més en la base de
dades.

3.3. Exercici 3 (opcional)

Utilitza el bundle jenssegers/dóna't en l'aplicació de tasques, i
defineix un nou mètode en TareaController amb URI /temps, que indique
per a cada tasca de la base de dades quant temps falta perquè finalitze
el termini. Per exemple:

