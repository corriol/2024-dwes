# Activitats

## Formularis

401. `401ExempleGet.php`: Crea una pàgina que reba com a paràmetre un nom i mostre el text `Benvingut [nom]!!!` sent [nom] el nom has 
passat com a paràmetre.

402. `402formulari.html` i `402formulari.php`: Crea un formulari que tinga els següents camps:
        
     * Nom i cognoms (`name`)
     * Correu electrònic (`email`)
     * Telèfon (`phone`)
     * URL de la pàgina personal (`url`).
  

    En l'atribut `action` del formulari posarem el següent:

    ```html
    <form action="402formulari.php" method="POST" .../>
    ```

    Açò farà que siga la pàgina `402formulari.php` la que processe les dades del formulari.

    En prémer `Enviar` han d'aparèixer en la pàgina les dades que s'han introduït en format de 
    taula.

403. `403formulariReparat.php`: Soluciona el problema dels paràmetres no enviats en accedir directament a la pàgina de processament del formulari.

404. `404formulariValidat.php`: Modifica l'exercici anterior realitzant les següents validacions:
      * Tots els camps són obligatoris.
      * `name`, no pot superar els 100 caracters.      
      * `phone`, serà un _string_ i ha de contenir 9 digits (expressió regular: `^\d{9}$`).
      * `email`, ha de ser una adreça electrònica correcta.
      * `url`, ha de ser una url vàlida.

    S'avaluaran tots els camps i si hi ha error/s caldrà mostrar-lo/s. Si no hi ha errors es mostraran les dades introduïdes per l'usuari.

405. `405formulariOpcions.html` i `405formulariOpcions.php`: Modifica l'exercici anterior afegint els següents camps al formulari:
      * `genre`: serà un _radio button_ i podrà ser _home_, _dona_ i _no binari_.
      * `hobbies`: serà un _checkbox_ amb aficions de la que podràs triar-ne més d'una:
        * Lectura
        * Programació
        * Ciclisme
        * Córrer
        * ...
      * `contact_time`: serà una llista de les millores hores per a contactar: 
        * Primera hora (08:00 a 10:00)
        * Abans de dinar (12:00 a 13:00)
        * Després de dinar (14:00 a 16:00)
        * A la nit (20:00 a 22:00)
      
    En els tres casos són obligatoris.

406. `406formulariUnic.php`. Modifica l'exercici anterior de forma que tant el formulari com el seu processament es realitze en el mateix fitxer. Si totes les dades enviades són correctes es mostrarà la taula amb la informació enviada. En cas d'error es mostraran dalt i el formulari guardarà els valors vàlids en cas d'error (_sticky form_).

407. `407formulariArray`: Modifica l'exercici anterior de forma que el contingut dels camps de selecció es genere dinàmicament des d'arrays associatius. Les claus seran `man`, `woman`, `nobinary` per als gèneres, `reading`, `programming`, `cycling`, `running` per a les aficions i `morning`, `before_lunch`, `after_lunch` i `evening` per a les hores de contacte. A més, els valors rebuts s'haurien de validar-se contra l'_array_, és a dir, que el valor enviat és una clau vàlida de l'array. També caldrà mostrar en la taula els valors dels arrays, no les claus.


## Inclusió de fitxers

410.   `410formulari.php`: Basant-te en l'activitat `407formulariArray.php` modifica les validacions perquè es facen mitjançant funcions. 
     
     Les funcions es guardaran en el fitxer `helpers.php` i s'hauran d'incloure en fitxer `410formulari.php`.

411.  `411formulari.php`: Basant-te en l'activitat `410formulari.php` separa la part de codi de la presentació de forma que tota la lògica estiga en un fitxer i la part de presentació en altre fitxer `411formulari.view.php`.
  

## Pujada de fitxers

420.   `420formulariImatge.php`: Modifica l'activitat anterior afegint un camp de tipus `FILE` per a pujar una imatge al servidor. Es guardarà en la carpeta `uploads` i es mostrarà amb la resta de dades. 
421.   `421FormulariImage.php`: Modifica l'activitat anterior de forma que es controle el següent:
     1.   Les imatges sols podran ser `jpg`.
     2.   No podran superar 1MB de grandària
     3.   Es guardaran en un nom aleatori únic.

## Projecte Truiter

### Formularis

422. Pàgina d'inici de sessió.

     Crea en `login.php` un formulari d'inici de sessió:

     1. En un únic fitxer es mostrarà i processarà el formulari. 
     2. Les dades d'usuari estaran en un array associatiu.
     3. Si la validació és correcta es mostrarà un missatge de confirmació.
     4. De no ser-ho es mostrarà un missatge d'error.

### Cookies
430. Última visita. 

    Modifica la pàgina `index.php` de forma que emmagatzeme en una galleta l'últim instant en què l'usuari va visitar la pàgina. 

    Si és la seva primera visita, mostra un missatge de benvinguda. En cas contrari, mostra la data i hora de la seva anterior visita. 

    La galleta tindrà una durada d'una setmana.

    Comprova que la galleta s'ha creat correctament.

430. Emmagatzematge del nom de l'usuari.

     L'objectiu és que quan un usuari inicie sessió s'emmagatzeme el nom introduït en un galleta, de forma que quan torne a accedir al formulari d'inici de sessió aparega el nom automàticament.

     El nom de la _cookie_ serà `last_used_name` i la durada serà de 30 dies.
     
     Crea la pàgina `logout.php` que en accedir eliminarà la _cookie_.

433. Assegurant les galetes.

     Després de llegir l'article enllaçat als apunts, aplica els canvis oportuns per a fer més segures les _cookies_.

### Maneig de sessions


434.   Registre de visites

    Modifica la pàgina inicial del projecte (`index.php`) de forma que s'emmagatzeme en la sessió d'usuari els instants de totes les seves últimes visites. Si és la seva primera visita, mostra un missatge de benvinguda. En cas contrari, mostra la data i hora de totes les seves visites anteriors. Afegeix un botó a la pàgina que permeta esborrar el registre de visites.

435.   Control d'accés
     
     Modifica el projecte de forma que en iniciar sessió (`login.php`) s'emmagatzeme un _token_ en una variable de sessió. Aquesta variable ens servirà per comprovar si l'usuari ja ha iniciat sessió correctament. Un usuari sols podrà accedir a la pàgina `logout.php` si ha iniciat sessió.

     En aquest cas, en inicar la sessió correctament caldrà redirigir a l'usuari a la pàgina principal mitjançant un missatge flaix que mostre el text: "L'usuari **administrador** ha iniciat sessió correctament".


436. Nous tuits
      
     Crea la pàgina `tweet-new.php` que contindrà un formulari per a la creació d'un tweet.     

437. Evitar atacts CSRF

    Implementa en el formulari de creació de tuits la solució proposada en els apunts.

438. Gestió de formularis en dos fitxers.

    Modifica el formulari de creació de tuits de forma que es gestione en dos fitxers tal com s'indica en els apunts.

439. Bones pràctiques

    Adapta el projecte de forma que:

     1.  Cada 15 minuts es regenere la sessió.
     2.   Sols use http per accedir a la _cookie_ de sessió.
     3.   Les constrasenyes s'encripten amb _bcrypt_.
     4.   Es tanque la sessió tal com s'indica.


## Sessions

440. Fes una còpia del formulari de l'activitat 407 i modifica'l de forma que es gestione en tres pàgines:
     1.   `form.php` que mostrarà el formulari amb els errors quan hi hagen.
     2.   `form_process.php` que processarà el formulari de forma que:
          1.    En cas d'error redirigirà a `form.php` emmagatzemant en una variable de sessió els errors i les dades correctes.
          2.    En cas d'èxit redirigirà a `form_success.php` que mostrarà en format de taula les dades enviades.
     3.  `form_success.php` que mostrarà en format de taula les dades del formulari


## Truiter

450. Clona el repositori <https://github.com/corriol/2023-truiter> i integra, respectant l'estructura definida, totes les activitats que han de vore amb el projecte: inici i tancament de sessió i creació de nous tweets.