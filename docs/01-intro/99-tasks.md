
# Activitats

## Aplicacions Web

111. Inspeccionant sol·licituds des del terminal

    `curl` és un programari realitzar sol·licituds HTTP, és a dir, un client HTTP, des de la línia de comandaments. Permet l'automatització de les sol·licituds.
    
    Usa `curl` per a accedir a les següents URL i registra en un documents les respostes incloent el codi d'estat i el tipus MIME:

    - http://www.google.com
    - https://google.com
    - https://www.google.com
    - https://www.google.com/x

    L'ordre concreta és:

    ```
    curl -sSL -D - URL -o /dev/null
    ```

112. Inspeccionats sol·licituds HTTP des del navegador

    Des de l'opció `Eines per a desenvolupadors` de Firefox és possible accedir a la pestanya `Xarxa` per poder comprova totes les sol·licituds que ha generat la URL a la que hem accedit.

    Activa l'opció anterior i accedeix a Google. Fes una captura de les sol·licituds que inclouen JS, CSS i Imatges.



113. Busca tres ofertes de treball de desenvolupament de software a Infojobs en la província d'Alacant que citen PHP i anota:

    Empresa + lloc de treball + frameworks PHP + requisits + salari + enllç a l'oferta.



## Entorn de desenvolupament

121. Instal·lació de l'entorn de desenvolupament LAMP
  
    Seguint les instruccions dels apunts instal·la l'entorn de desevolupament

122. Instal·lació de PHPStorm

     Seguint les instruccions dels apunts instal·la i configura PHP Storm.

123. Prova d'Apache i PHP
     
    L'objectiu d'aquesta pràctica és aprendre el maneig bàsic de l'entorn de desenvolupament PHPStorm creant una primera pàgina PHP que alhora servirà per a comprovar la correcta instal·lació de XAMPP.

    Seguint les instruccions dels apunts crea projecte i prova'l.

124. Instal·laciò d'XDebug

    Seguint les instruccions dels apunts instal·la i configura XDEBUG i connecta'l a PHP Storm. 

125. Creació d'un _virtualhost_

    Crea un nou host virtual que responga a la url: `bloc-i.local` i el document arrel (_document root_) siga el directori `/home/USUARI/projectes/bloc-i`.

    Crea en el _document root_ un fitxer `index.php` que contiga

    ```php
    <?php echo "Hola mon!" ?>
    ```
    Comprova que funciona accediant a `http://bloc-i.local`.

