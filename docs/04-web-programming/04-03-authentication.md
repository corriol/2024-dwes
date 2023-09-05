# Autenticació d’usuaris

Moltes vegades és important verificar la identitat dels dos extrems d’una comunicació, hi ha mètodes per identificar tant al servidor en el qual s’allotja el lloc web, com a l’usuari del navegador que es troba en l’altre extrem.

Els llocs web que necessiten emprar identificació de servidor, com les botigues o els bancs, utilitzen **el protocol HTTPS**. Aquest protocol requereix un certificat digital vàlid, signat per una autoritat fiable, que és verificat pel navegador quan s’accedeix a la pàgina web. A més, HTTPS utilitza mètodes de xifrat per crear un canal segur entre el navegador i el servidor, de tal manera que no es puga interceptar la informació que es transmet pel mateix.


Per identificar els usuaris que visiten un lloc web, es poden utilitzar diferents mètodes com el DNI digital o certificats digitals d’usuari (document digital que conté informació sobre l’usuari com el nom o l’adreça. Aquesta informació està signada per una altra entitat, anomenada entitat certificadora, que ha de ser de confiança i garanteix que la informació que conté és certa), però el més estès és sol·licitar a l’usuari certa informació que només ell coneix: la combinació d’un nom d’usuari i una contrasenya.

És també habitual usar un formulari d'inici de sessió que valide les credencials de l'usuari contra una base de dades.  Una vegada identificat, es pot limitar l’ús que pot fer de la informació.

Així, pot haver-hi llocs web en els quals els usuaris autenticats poden utilitzar només una part de la informació (com els bancs, que permeten als seus clients accedir únicament a la informació relativa als seus comptes). Altres llocs web necessiten separar en grups o rols als usuaris autentificats, de tal manera que la informació a la qual accedeix un usuari depèn del grup o rol en què aquest es trobe. Per exemple, una aplicació de gestió d’una empresa pot tenir un grup d’usuaris als qui permet visualitzar la informació, i un altre grup d’usuaris que, a més de visualitzar la informació, també la poden modificar. **Els mecanismes per al manteniment de l'estat són fonamentals per poder dur a terme aquesta tasca**.

També és possible autenticar usuaris mitjançant l'autenticació HTTP, la qual cosa excedeix l'abast d'aquest mòdul.

!!! info
    Has de distingir l’autenticació dels usuaris i el control d’accés, de la utilització de mecanismes per assegurar les comunicacions entre l’usuari del navegador i el servidor web. Encara que tots dos aspectes solen anar units, són independents.

En els exemples d’aquesta unitat, la informació d’autenticació (nom i contrasenya dels usuaris) s’envia en text pla des del navegador fins al servidor web. Aquesta pràctica és altament insegura i mai s’ha d’usar sense un protocol com HTTPS que permeta xifrar les comunicacions amb el lloc web. No obstant això, la configuració de servidors web que permeten fer servir el protocol HTTPS per xifrar la informació que reben i transmeten no forma part dels continguts d’aquest mòdul. Per aquest motiu, durant aquesta unitat utilitzarem únicament el protocol no segur HTTP.

## Sistema d'autenticació

Per a proveir d'un sistema d'autenticació senzill necessitarem:

- Mostrar el formulari d’inici de sessió/contrasenya
- Comprovar les dades enviades
- Afegir algun tipus de _token_ a la sessió
- Comprovar el _token_  per a dur a terme tasques d’usuari específiques
- Eliminar el _token_ la sessió quan l’usuari la tanque.

El formulari d'inici de sessió podria ser semblant aquest:

```html
<form action="login.php" method="post" novalidate>
    <div>
        <label for="username">Username</label>
        <input type="text" name="username" id="username"               
               required>
    </div>
    <div>
        <label for="password">Contrasenya</label>
        <input type="password" name="password" id="password"
                required>
    </div>
    <input type="submit" value="Inicia sessió">
</form>
```

Una vegada enviat el processaríem: 

```html+php hl_lines="15 16"
<?php
// Comprovem si el formulari ja s’ha enviat
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Validem que rebem els dos paràmetres
    if (empty($usuario) || empty($password)) {
        $errors[] = "Heu d'introduir un usuari i una contrasenya";
        
    } else {
        // Caldria adaptar-ho segons on tingam les credencials dels usuaris
        if ($username == "admin" && $password == "admin") {
            // Emmagatzemem l’usuari a la sessió
            session_start();
            $_SESSION['user'] = $username;
            
        } else {
            $errors[] = "L'usuari o la contrasenya no són vàlides.";        
        }
    }
}
```

Una vegada iniciada la sessió podríem controlar que sols els usuaris autenticats pogueren entrar
ho faríem així.

```html+php
<?php
    // Recuperem la informació de la sessió
    if(!isset($_SESSION)) {
        session_start();
    }

    // I comprovem que l'usuari s'ha autenticat
    if (empty($_SESSION['user'])) {
       die("Error - debe <a href='login.php'>identificar-se</a>.<br />");
    }
?>
<!DOCTYPE html>
<html lang="ca">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Llista de productes</title>
</head>
<body>
    <h1>Benvingut <?= $_SESSION['usuario'] ?></h1>
    <p>Polse <a href="logout.php">ací</a> per a eixir</p>
    <p>Tornar a l'<a href="index.php">inici</a></p>
    <h2>Llista de productes</h2>
    <ul>
        <li>Product 1</li>
        <li>Product 2</li>
        <li>Product 3</li>
    </ul>
</body>
</html>
```

Per a tancar la sessió eliminaríem la variable de sessió `user`.

```html+php
<?php
// Recuperem la informació de la sessió
session_start();

// I la destruïm
session_destroy();
header("Location: index.php");
exit();
?>

```
