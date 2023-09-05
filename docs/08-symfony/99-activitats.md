# Activitats

## Introducció

801. Entorn de desenvolupament

    Després dels tres primers apartats de la primera sessió, ja hauries de tenir
    operativa la màquina virtual amb XAMPP i Composer instal·lats.

    En qualsevol dels dos casos, i per a verificar que la teua instal·lació
    és correcta abans de continuar, es demana que realitzes dues captures de
        pantalla:

    1.  Engega Apache i MySQL des del manager de XAMPP, accedeix amb Firefox
    a la URL http://localhost i captura la pantalla que mostra el
    navegador. Guarda-la en un arxiu anomenat "xampp.png".
    2.   Des d'un terminal, executa el comando: `composer --version` i fes captura
    on es veja la versió de Composer que tens instal·lada.
    Guarda-ho en "composer.png".

## El patró MVC

802. Posada a punt dels projectes
     
    En aquest exercici crearem un projecte Symfony anomenat `movies-symfony`,
    que anirem completant en sessions posteriors, en la carpeta de treball amb l'estructura bàsica de `website-­skeleton`.

    Després de crear-lo, afig un virtual host per a poder accedir al
    projecte amb la URL `http://movies-symfony`

    Repeteix els mateixos passos per a un altre projecte anomenat `00-nom-symfony`,
    també allotjat en la teua carpeta de treball. Afig
    el corresponent virtual host per a accedir a ell amb la URL `http://00-nom-symfony`

    Aquest projecte contindrà el teu projecte personal, que anariàs completant
    a mesura que vages aprenents a utilitzar Symfony.

    Crea un repositori privat de Github per al projecte personal amb el mateix nom que el projecte. Comparteix-lo amb el professor.

    Com a resultat d'aquest exercici, hauràs d'adjuntar una captura de
    pantalla per a cada projecte, on es veja en el navegador la URL
    corresponent (`http://movies-symfony` o `http://00-nom-symfony`, respectivament), 
    i la pàgina de benvinguda per defecte de Symfony.
    
    Guarda les captures com a "movies.png" i "projecte.png".

803.   Controladors

    Seguint els passos de l'apartat _El patró MVC en Symfony_, implementa el controlador `HomeController`.

## Twig

804.   Plantilles en Twig    
    
    Adapta la plantilla base (`templates/base.html.twig`) perquè importe Bootstrap 5.0.

    Afig a l'array de pel·lícules la clau `poster` amb el nom del fitxer i canvia el format de la data a `DateTime` o `timestamp`. 

    Modifica les plantilles `home.html.twig`, `movies_show.html.twig` i `movies_filter.html.twig` perquè hereten de la plantilla base.

    Crea un plantilla `_movie_data.html.twig` que tinga les dades de la pel·lícula. Modificació la resta de plantilles perquè mostren les dades de cada pel·lícula fent ús d'aquesta.

## Contenidor de serveis

805. DBTest
     
    Crea el servei `DBTest` vist en la sessió i fes-ne ús en `MovieController`. D'aquesta
     forma l'array de pel·lícules l'obtindrem des del servei.

    A més, modifica `HomeController` perquè en faça ús.

    Finalment, modifica `home.html.twig`  perquè s'assemble a les de projecte `Movies`.

806. Logger
    
    Implementa el sistema de registre en `HomeController`, de forma que cada vegada
    que s'accedisca a la pàgina principal quede registrada la data i l'hora d'accés.

    El format de la data es podrà configurar globalment.


## Doctrine

807. En l'aplicació de pel·lícules, crea una nova entitat anomenada `Movie` amb
els següents atributs:

    - title (_string_ de grandària 255)
    - poster (_string_ de grandària 255)
    - overview (_text_)
    - releaseDate(_DateTime_)

    Recorda definir prèviament la
    variable `DATABASE_URL` en les variables d'entorn, crear la base de
    dades, i després migrar aquests canvis a la base de dades, emprant els
    comandos vistos en aquesta sessió.

    El camp `id` (_enter_, autonumèric) es crea automàticament.


808. Realitza l'exercici anterior en el teu projecte Symfony, creant la base de dades,
l'entitat principal i la taula relacionada en la base de dades.


809. Implementa el mètode `create` vist anteriorment en el projecte `Movies`.


810. Sobre la base de dades del teu projecte i l'entitat/taula principal que hem creat
en l'exercici anterior, implementa mitjançant un controlador per a l'entitat:

     1.  Implementa un nou mètode del controlador anomenat `create`, que cree un element en la base de dades
     2.  Implementa el mètode `show` que obtindrà un element de la base de dades pel seu id.
     3.  Implementa el mètodo `home()` en la classe `HomeController`
    perquè mostre el llistat de la taula principal de MySQL en lloc de la
    base de dades de proves.

811. Modifica el mètode `filter` anterior de la classe `MovieController`  i perquè cerque els elements que continguen una text determinat 
però enviat pel _query string_. Anirà associat a la URI `/movies/filter` i  renderizará una vista (pot ser la pàgina principal), 
passant-li com a paràmetre el llistat filtrat.

    Per a obtenir els paràmetres del query string has d'usar la classe
    [Request](https://symfony.com/doc/current/components/http_foundation.html#request) creant 
    l'objecte posant-lo com a paràmetre tipat.

    Per exemple:

    ```php
        public function filter(Request $request) {
        $text = $request->query->getAlnum("text");
        ...
    }
    ```

    Empra per a fer la consulta o bé el _Query Builder_ de Doctrine o bé el
    seu llenguatge DQL, afegint el mètode corresponent en el repositori de
    l'entitat.

812. Implementa la relació de Genre i Movie en el projecte `movies-symfony`.

813. En el projecte personal crea una nova entitat relacionada i
    implementa la inserció amb d'un element amb l'entitat relacionada.



814. En el projecte `Movies` afig la configuració de seguretat seguint els següent requeriments:
     
     - Crea una entitat `User` de forma similar a com hem fet per en els exemples, i la corresponent taula. 
    L'entitat tindrà els mateixos camps que en l'exemple.
     - Defineix un formulari de _login_ com el de l'exemple, i
    configura l'arxiu `config/packages/security.yaml` perquè utilitze
    aquest formulari, sota la ruta `/login` (defineix també el controlador
    associat a aqueixa ruta, com en l'exemple)
     - Protegeix l'accés a la creació de pel·licules (ruta `/movies/create`),
    perquè només usuaris de tipus `ROLE_ADMIN` puguen accedir. Crea un
    usuari d'aquest tipus en la base de dades manualment, per a
    poder-ho provar.
     - Crea la jerarquia de rols de l'exemple i fes que a la ruta `/admin`
    sols hi puguen accedir els usuaris amb `ROLE_ADMIN`
     -  Canvia les routes dels CRUD de pel·lícules i gèneres de forma que comencen per
   `/admin` així s'aplicarà la restricció anterior.   

815. Sobre l'autenticació anterior, afegirem aquests canvis:

     -   Codifica els passwords de l'aplicació amb l'algorisme triat per Symfony, i
    Codifica manualment els passwords dels usuaris que hages
    afegit a la base de dades, usant la web que s'ha proporcionat en
    els apunts.
     -   Afig un enllaç per a "Iniciar sessió" en la plantilla.
     -   Afig un enllaç "Tancar sessió" en la plantilla `base.html.twig` perquè
    es puga tancar sessió des de qualsevol vista de la web.
     -   Els dos enllaços anteriors són incompatible, fes que si l'usuari ha iniciat
    sessió aparega el de tancar i viceversa.    
     -   Opcionalment, fes que aparega el nom d'usuari al costat de l'enllaç de tancar sessió.     


816. Aplica els mateixos canvis en el projecte personal, respectant la funcionalitat de rols
que havies previst.

