# Activitats
## PHP Bàsic

  201.  `201tresfrases.php`: Mostra 3 frases, cadascuna en un paràgraf utilitzant les tres possibilitats que hi ha de mostrar contingut. Després, introdueix dos comentaris, un de bloc i un altre d'una línia.

  202. `202calculs.php`: Escriu un programa que utilitze les variables `$x` i `$y`. Assigna'ls els valors `166` i `999` respectivament. Tot seguit, mostra per pantalla el valor de cada variable, la suma, la resta, la divisió i la multiplicació.

  203. `203dadesPersonals.php`: Escriu un programa que emmagatzeme en variables teu nom, primer cognom, segon cognom, email, any de naixement i telèfon. Després mostra'ls per pantalla dins d'una taula.     
   
    |  |  |  |   
    | -- |-- |--|
    | Nom | Bruce |  |   
    | Cognoms | Wayne |  |
    | Email | batman@dccomics.com |  |
    | Any de naixement | 1939 |  |
    | Telèfon | 555666777 |  |


  204. `204dadesPersonales.html` i `204dadesPersonales.php`: És el mateix exercici que l'anterior, però separant la lògica. En el primer fitxer crearem el formulari per a introduir les dades i després recollirem les dades i generarem la taula en el segon arxiu.

  205.  `205anys.php`: Després de llegir l'edat d'una persona per la URL, mostrar l'edat que tindrà d'aquí a 10 anys i fa 10 anys. A més, mostra quin any serà en cada un dels casos. Finalment, mostra l'any de jubilació suposant que treballaràs fins als 67 anys. No cal que faces un formulari, pots provar-ho directament via URL: `205anys.php?edad=33`.

   Tip: `$currentYear = date("Y")`;

  206. `206diners.php`: A partir d'una quantitat de diners, mostrar la seva descomposició en bitllets (500, 200, 100, 50, 20, 10, 5) i monedes (2, 1) perquè el nombre d'elements sigui mínim. No es pot utilitzar cap instrucció condicional. Per exemple, en introduir `139` ha de mostrar:

  ```
  1 bitllet de 100
  0 bitllet de 50
  1 bitllet de 20
  1 bitllet de 10
  1 bitllet de 5
  2 moneda de 2
  ```
  Tip: Pots forçar a realitzar la divisió sencera mitjançant la funció `intdiv($dividend, $divisor)` o passar un nombre flotant a sencer pots fer servir la funció `intval()`.

207. `207posnegzero.php`: A partir d'un número, mostra per pantalla si el número és positiu, negatiu o zero.

208. `208mayor3.php`: Sense fer ús de condicions que utilitzen dins de la condició els operadors lògics, mostra el més gran de tres números (a, b i c).

209. `209mayor3c.php`: Utilitza en les condicions els operadors lògics.

210. `210nomEdad.php`: A partir d'una edat mostra per pantalla:

```
 nadó si té menys de 3 anys
 nen si té entre 3 i 12 anys
 adolescent entre 13 i 17 anys
 adult entre 18 i 66
 jubilat a partir de 67
```

### Exercicis d'investigació
    
211. Investiga perquè serveix l'operador nau espacial, disponible des de PHP7 (<https://www.php.net/manual/es/migration70.new-features.php>). Explica amb un parell de línies el seu propòsit i mitjançant el codi demostra el seu ús.

212. Investiga per a què serveix la instrucció `match()`, disponible des de PHP8 (<https://www.php.net/manual/ca/control-structures.match.php>). Explica amb un parell de línies el seu propòsit i mitjançant el codi demostra el seu ús.

## Dates

213. `213Dates.php`: Crea un fitxer que realitza les següents tasques:

    1.  Mostra la data i hora actuals amb el format: `dd/mm/yyyy hh:mm:ss`
    2.  Mostra el nom de la zona horària que s'utilitza per defecte.
    3.  Mostra la data de que serà d’ací 45 dies.
    4.  Mostra el nombre de dies que han passat des de l'1 de gener.
    5.  Mostra la data i hora actuals de Nova York.
    6.  Mostra el dia de la setmana que era l'1 de gener d'enguany.
    
## Cadenes

214.   `214Cadenes.php`: Crea una pàgina que reba un nom. Amb la directiva de tipus estricta (`declare( strict_types = 1 );`) aplica les següents funcions: 

    1. Elimina els espais del principi i el final del nom si els hi haguera (_trim_). 
    2. Elimina la lletra `a` del principi i el final del nom si els hi haguera (_trim_). 
    3. Mostra la variable `nom` en majúscules, minúscules i amb la primera lletra en majúscula i les altres en minúscules (_strtoupper_, _strtolower_, _ucfirst_). 
    4. Mostra el codi ascii de la primera lletra del nom (_ord_). 
    5. Mostra la longitud del nom (_strlen_). 
    6. Mostra el nombre de vegades que apareix la lletra `a` (majúscula o minúscula, _substr_count_). 
    7. Mostra la posició de la primera `a` existent en el nom, siga majúscula o minúscula (_strpos_). Si no hi ha cap mostrarà -1. 
    8. El mateix, però amb l''última `a`. 
    9. Mostra el nom substituint la lletra `o` pel número `0`, siga majúscula o minúscula (_str_replace_). 
    10. Indica si el nom comença per `al` o no. 


215.   `215Cadenes.php`: Utilitza la funció `parse_url` per a extraure de la url les següents parts: 
    
      1. El protocol utilitzat (en l'exemple "http").  
      2. El nom d'usuari (en l'exemple "username").
      3. El _path_ de la url (en l'exemple "/path").
      4. El _querystring_ de la url (en l'exemple "arg=value").

    ```php
    $url = "http://username:password@hostname:9090/path?arg=value#anchor";
    ``` 

### Bucles

220. `220parells050.php:` Escriu un programa que mostre els números parells del 0 al 50 (dintre d'una llista desordenada).

    `220parellsAB.php`: A partir de l'anterior, refacciona perquè funcione amb els paràmetres `inici` i `fi`.

221. `221suma110.php`: Escriu un programa que sume els números de l'1 al 10.

    `221sumaAB.php`: A partir de l'anterior, refacciona perquè funcione amb `inici` i `fi`.

222. `222potencia.php`: A partir d'una base i exponent, mitjançant l'acumulació de productes, calcula la potència utilitzant l'instrucció `for`.

    `222potenciaWhile.php`: Reescriu l'exercici anterior fent ús de `while`.
    `222potenciaDoWhile.php`: Reescriu l'exercici anterior fent ús sols de `do-while`.

223. `223taulaMultiplicar.php`: Mostra dins d'una taula HTML la taula de multiplicar d'un `número`. Utiliza `<thead>` amb els seus respectius `<th>` y `<tbody`> per a dibujar la tabla. Per exemple:

    a | * | b | = | a*b
    -- | -- | -- | -- | --
    7  | * | 1 | = | 7
    7  | * | 2 | = | 14
    ...
    7  | * | 10 | = | 70

224. `224formulari.html`: Crea un formulario que permeta llegir una `quantitat`.  `224llegirDades.php`: A partir de `quantitat`, prepara un formulari amb tantes caixes (_textbox_) com el valor de `quantitat` rebut. Finalment, en `224sumarDades.php`: a partir de les dades de totes les caixes de text de la pàgina anterior, suma i mostra el total.

225.   `225formulari.html` i `225taula.php`: A partir d'un nombre de `files` i `columnes`, crear una taula amb aquesta mida.
Les cel·les han d'estar emplenades amb els valors de les coordenades de cada cel·la.
226.   `226formulari.html` i `226quadrat.php`: Basant-te en l'exercici anterior, omple la taula de manera que només les vores tinguin contingut, quedant-se la resta de cel·les en blanc.
![228](assets/02p228.png){align=right & width=200}
227.   `227formulari.html` i `227equis.php`: Basant-te en l'exercici anterior, ara només ha d'aparèixer el contingut dels dos diagonals.
228.   `228quadratMultiplicar.php`: Crea un programa que mostre per pantalla un quadrat exactament igual (fixa't bé a les capçaleres, tant de les files com de les columnes) al de la imatge amb les taules de multiplicar.

## Arrays 

230. `230aleatoris50.php`: Omple un _array_ amb 50 números aleatoris compresos entre el 0 i el 99, i després mostra'l en una llista desordenada.
Per crear un nombre aleatori, utilitzeu la funció `rand(inici, fi)`. Per exemple:

    ```php
    $num = rand(0, 99)
    ```

231. `231bola8.html`: Prepara un formulari amb una caixa de text que faça una pregunta a l\'usuari.
`231bola8.php`: A partir de l'anterior, crea un programa que mostre la pregunta rebuda i genere una resposta de manera aleatòria entre un conjunt de respostes predefinides, emmagatzemades en un _array_: *Si, no, potser, és clar que sí, per suposat que no, no ho tinc clar, segur, jo diria que sí, ni de conya, etc.*.

    Aquest exercici es basa en el joc de la [Bola 8 màgica](https://es.wikipedia.org/wiki/Magic_8-Ball).

232. `232mates.php`: A partir de l'exercici 230, genera un array aleatori de 33 elements amb números compresos entre el 0 i 100 i calcula:

    * El major
    * El menor
    * La mitjana

233. `233sexos.php`: Omple un array de 100 elements de manera aleatòria amb valors `M` o `F`.
Un cop completat, torna a recórrer-lo i calcula quants elements hi ha de cadascun dels valors. Per això, emmagatzema el resultat en un array associatiu `['M' => 44, 'F' => 56]`.

    Finalment, mostra el resultat per pantalla

234. `234monedes.php`: Torna a fer l'exercici 206, el de les monedes (500, 200, 100, 50, 20, 10, 5, 2, 1), però fent ús d'arrays i un bucle.
Emmagatzema el resultat en un _array associatiu_.
Mostra el resultat en una llista desordenada només amb les quantitats que tenen algun valor.

235. `235altures.php`: Mitjançant un array associatiu, emmagatzema el nom i l'alçada de 5 persones (`nom => altura`).
Posteriorment, recorre l'array i mostra-ho en una taula HTML.
Finalment afegeix una darrera fila a la taula amb l'alçada mitjana.

236. `236persones.php`: Mitjançant un array bidimensional, emmagatzema el nom, alçada i email de 5 persones. Per això, crea un _array_ de persones, sent cada persona un array associatiu: `[ ['nom'=>'Aitor', 'altura'=>182, 'email'=>'aitor@correo.com'],[ …],… ]`
Posteriorment, recorre l'array i mostra'l en una taula HTML.

237. `237llegirQuantitat.html` i `237llegirPersones.php`: a partir d'un formulari amb un camp de `quantitat` de persones, generar un nou formulari per llegir el nom, alçada i email de `quantitat` persones.
`237gestionarPersones.php`: A partir de les persones introduïdes, mostrar les vostres dades en una taula, i posteriorment, destacar les dades del més alt i la del més baix.

238. `238taulaDistints.php`: Omple un array bidimensional de 6 files per 9 columnes amb números aleatoris compresos entre 100 i 999 (tots dos inclosos). Tots els números han de ser diferents, és a dir, no se'n pot repetir cap.
Mostra a continuació per pantalla el contingut de l'array de manera que:

    * La columna del màxim ha d'aparèixer en blau.
    * La fila del mínim ha d'aparèixer en verd
    * La resta de números han d'aparèixer en negre.

239.   `239Arrays.php`: Crea una pàgina i resol els exercicis següents utilitzant funcions d'arrays:
     1. Crea un array amb els noms de diversos alumnes de la classe incloent el teu. 
     2. Mostra el nombre d'elements que té l'array (_count_). 
     3. Crea una cadena de text que continga els noms dels alumnes existents en l'array separats per un espai i 
mostra-la (_implode_).
     1. Mostra l'array en un ordre aleatori diferent al que ho vas crear (_shuffle_). 
     2. Mostra l'array ordenat alfabèticament (_sort_). 
     3. Mostra els alumnes el nom dels quals continga almenys una “a” (_array_filter_).
     4. Mostra l'array en l'ordre invers al que es va crear (_rsort_). 
     5. Mostra la posició que té el teu nom en l'array (_array_search_).

240. `240Ciutats.php`: Segons l'INE les 7 ciutats més grans d’Espanya (per habitants) el 2018 van ser les següents:

     - Madrid, MAD,	3.223.334
     - Sevilla, AN	, 688.711
     - Murcia, MU,	447.182
     - Málaga, AN,	571.026
     - Zaragoza, AR, 666.880
     - València, CV,	 791.413
     - Barcelona, CAT, 1.620.343

    Copia `index.php` i crea un nou document `cituats.php`. Defineix un array que continga aquesta informació sobre ciutats i 
habitants. Imprimeix una taula d'ubicacions i habitants que incloga la població total de les 7 ciutats.

    Opcional:
    Modifica la solució de l’anterior exercici perquè mostre les ciutats ordenades per habitants. Després mostra-les per ordre alfabètic.



241. `241Alumnes.php`: Resol els exercicis següents utilitzant funcions d'arrays: 

     1. Crea un array d'alumnes on cada element siga un altre array que continga nom i edat de l'alumne. 
     2. Crea una taula HTML en la qual es mostren totes les dades dels alumnes. 
     3. Utilitza la funció `array_column` per a obtenir un array indexat que continga únicament els noms dels alumnes i mostra’ls per pantalla.    
     4. Crea un array amb 10 números i utilitza la funció `array_sum` per a obtenir la suma dels 10 nombres. 
     5. Sense usar bucles for calcula la mitjana d'edat de l'alumnat.     


242. `242CiutatsOpcional.php`: Modifica la solució del exercici `ciutats.php` perquè la taula continga també la columna del total d’habitants de la 
comunitat autònoma de les ciutats de la llista i el percentatge sobre els habitants de la comunitat autònoma que representa.

    Per exemple: 

    | Ciutat | Habitants | Habitats CA | % sobre CA |
    | -- | --: | --: | --: | 
    | València | 791.413 |  5.003.769 | 15.81% | 

    Pista: Caldrà modificar l'array  `$ciutats` i convertir-lo en multidimensional. Les dades de comunitats autònomes hauran
    d'estar en un altre array. 

    Dades: [Municipis de España](https://es.wikipedia.org/wiki/Anexo:Municipios_de_Espa%C3%B1a_por_poblaci%C3%B3n)

## Funcions

250. `250arrayParell.php`: Crea les funcions següents:
     - Una funció que esbrina si un nombre és parell: `esParell(int $num): bool`.
     - Una funció que retorne un array de mida `$tam` amb números aleatoris compresos entre `$min` i `$max` : `arrayAleatori(int $tam, int $min, int $max): array`.
     - Una funció que reba un `array` amb números aleatoris per referència i torne la quantitat de nombres parells que hi ha emmagatzemats: `arrayParells(array &$array): int`.

251. `251parametrosVariables.php`: Crea les funcions següents:
     - Una funció que retorne el nombre més gran de tots els números rebuts com a paràmetres: function `major(): int`. Utilitza les funcions ` func_get_args()`, etc... No pots fer servir la funció `max()`.
     - Una funció que concatene tots els paràmetres rebuts separant-los amb un espai: `function concatenar(...$paraules) : string`. Utilitza l'operador `.`.

252. `252matematiques.php`: Afegeix les funcions següents:

    - `digits(int $num): int` → retorna la quantitat de dígits d'un número.
    - `digitN(int $num, int $pos): int` → torna el dígit que ocupa, començant per l'esquerra, la posició `$pos`.
    - `llevarPerDarrere(int $num, int $quantitat): int` → li treu per darrere (dreta) `$quantitat` dígits.
    - `llevarPerDavant(int $num, int $quantitat): int` → li treu per davant (esquerra) `$quantitat` dígits.

Per provar les funcions, feu ús tant de pas d'arguments posicionals com arguments amb nom.

253. `253biblioteca.php`: crea un fitxer amb funcions per sumar, restar, multiplicar i dividir dos números.
254. `254arrayFunciones.php`: fent ús d'un array que emmagatzeme el nom de les funcions del fitxer anterior, a partir de dos números rebuts per URL, recorre l'array i invoca les funcions de manera dinàmica fent ús de funcions variable.

255. `255funcions.php`: Escriu una funció per retornar una etiqueta HTML `<img />`. 

      La funció hauria d’acceptar com a argument obligatori l’URL de la imatge i arguments opcionals per a un text 
      alternatiu, alçada i amplada.

256. `256funcions.php`: Copieu la funció de l’exercici anterior i modifiqueu-la de manera que només es passe el nom de fitxer a la funció en
lloc de l’URL completa. Dins de la funció, farem ús d’una variable global per fer l’URL completa.
  
      Per exemple, si passem `photo.png` a la funció, i la variable global conté `/images`, llavors l’atribut `src` de 
  l'etiqueta <img> retornada serà `/images/photo.png`. 

      Una funció com aquesta és una forma senzilla de mantenir correctes les vostres etiquetes d’imatges, fins i tot si les
      imatges es mouen a un nou camí o servidor. Només cal canviar la variable global, per exemple, de `/images` a 
      `http://images.example.com/.`


257. `257funciocolors.php`:  Els colors web com `#ffffff` i `#cc3399` es realitzen concatenant els valors hexadecimals de color per a vermell, 
verd i blau. 

    Escriu una funció que accepte 3 arguments: roig, verd i blau, i que retorne un string que conté el color adequat per
  utilitzar-lo en una pàgina web. 

     Per exemple, si els arguments són 255, 0, i 255, llavors la cadena retornada hauria de ser #FF00FF.
 
     Pot resultar útil utilitzeu la funció `dechex()` integrada, que es troba documentada a [http://www.php.net/](http://www.php.net/)

     Assegureu-vos que els paràmetres reben valors enters i que són colors vàlids.

     Implementa 3 exemples d’ús.

258.`258funcionsSQL.php`: Crea una funció anomenada `insert`  que ens genere una sentència INSERT INTO en SQL.  

    Per a açò la funció rebrà dos paràmetres:  
          1. El nom de la taula  
          2.   Un array associatiu que contindrà els noms i valors dels camps de la taula.
 
      La sentència resultant tindrà la següent forma: 

      ```
      “INSERT INTO nom_taula (nom dels camps separats per comes) 
        VALUES (noms dels camps separats per comes amb el caràcter “:” davant)  
      ```
    De moment, no farem res amb els valors dels camps. 

    Ajuda: utilitza les funcions `sprintf`, `implode` i `array_keys`

259.     `259funcionsSQL2.php`: A partir de l'exercici anterior crea una altra funció que reba els mateixos paràmetres més un paràmetre booleà 
per a indicar si volem generar la query amb els noms dels camps o no. 

     El paràmetre tindrà el valor `true` per defecte.
 
     Si el seu valor és `true` generarà la consulta igual que en l'exercici anterior, però si és `false` la generarà així: 

    ```sql
    INSERT INTO nom_taula 
      VALUES (valors dels camps separats per comes amb el caràcter ‘:’ davant)
    ```

260.     `260funcionsSQLReferencia.php`: Repeteix l'exercici anterior amb els següents canvis: 

    La cadena resultant es passarà per referència.

    Passarem la cadena de la següent forma: 

    ```sql
      INSERT INTO taula (camps) VALUES (valors) 
    ```

    Dins de la funció substituirem el següent: 

      1. El text taula pel nom de la taula. 
      2. El text camps pels noms dels camps separats per comes
      3. El text valors pels noms dels camps separats per comes i el caràcter ‘:’ davant. 


## Crèdits

* Aitor Medrano. (setembre de 2021) _Desarrollo Web en Entorno Servidor_ disponible en: [https://aitor-medrano.github.io/dwes2122/index.html](https://aitor-medrano.github.io/dwes2122/index.html)
