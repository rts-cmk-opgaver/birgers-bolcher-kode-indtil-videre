# Express - server, routes og database
###### Frank Goldmann - april 2019

Vel nok den simpleste definition af en node-server og route er flg.

### I roden oprettes **app.js**
```javascript
const express = require('express');
const app = express();

app.get('/', function(req, res){
    res.send("Tekst fra et route")
})

app.listen(3333);
console.log(`Serveren er startet på http://localhost:3333`);
```
Det to første linjer er først en reference til `express` og start af express, som gemmes i en `const` kaldet *app*.

Herefter oprettes et simpelt route, som blot har til formål at returnere en simpel tekst.

I efterfølgende eksempel lægges routet (og flere routes) i en ekstern fil i en mappe kaldet routes

I sidste del af koden startes serveren op med `app.listen(port)`. Efterfølgende udskrives til konsollen at serveren er startet. Den er meget rar at have, så man kan se at serveren kører.
## Routes i eksterne fil
### I roden oprettes en mappe kaldet **routes** med filen **index.js**
```javascript
module.exports = function (app) {

    app.get('/', function (req, res) {
        res.send("Frank")
    });

    app.get('/getUser', function (req, res) {
        let user = {
            "firstname": "Frank",
            "lastname": "Goldmann"
        }
        res.send(user)
    })

}
```
Filen indeholder 2 routes pakket ind i et module, som **app.js** kan `require`

Det første route er et "default route" som kun returnerer en tekst.

Det andet route `/getUser` returnerer et json-objekt

```javascript
const express = require('express');
const app = express();

require('./routes/index')(app);

app.listen(3333);
console.log(`Serveren er startet på http://localhost:3333`);`
```
## package.json, node_modules og start server
Inden vi kan starte serveren op skal package.json oprettes.
>Kør npm init

Se at package.json oprettes
>kør npm install express --save

Se at node_modules oprettes
>kør node app

Se at console.log udskriver *Serveren er startet på http://localhost:3333* 

Du kan nu åbne din browser med http://localhost:3333 og se navnet fra første route udskrives.

Skriver du /getUser (http://localhost:3333/getUser) vil det andet route blive kaldt og returnere json-objektet

>Du har nu oprettet dit første API

## Adgang med fetch
Hvis websider fra andre domæner, protokoller eller andre porte skal have adgang til dine routes vha. fetch skal denne tilladelse gives.
Det kan f.eks. gøres ved at indsætte flg. kode i app.js før `require('./routes/index')(app);`
som tillader adgang til alle routes fra alle kilder - det er et komplekst emne som er mindre vigtigt at forstå til at starte med.

```javascript
app.use('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    next();
});
```
## Hent data fra database
For at hente data fra databasen til dine routes må du først installere et node_module til mysql.
>Kør npm install mysql2 --save

Indsæt i starten af route-filen index.js, før `module.exports = ...` flg. kode
```javascript
const mysql = require('mysql2');

const db = mysql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'franksdemo'
});
```
Nu kan du oprette et nyt route som henter data og sender tilbage til klienten
```javascript
app.get('/getAllUsers', function (req, res) {
    db.query('SELECT * FROM bruger', function (err, rows) {
        if (err) {
            res.send(err)
        } else {
            res.send(rows)
        }
    })
})
```
## Den samlede kode
**app.js**
```javascript
const express = require('express');
const app = express();

app.use('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    next();
});

require('./routes/index')(app);

app.listen(3333);
console.log(`Serveren er startet på http://localhost:3333`);
```
**routes/index.js**
```javascript
const mysql = require('mysql2');

const db = mysql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'franksdemo'
});


module.exports = function (app) {

    app.get('/', function (req, res) {
        res.send("Frank")
    });

    app.get('/getUser', function (req, res) {
        let user = {
            "firstname": "Frank",
            "lastname": "Goldmann"
        }
        res.send(user)
    })

app.get('/getAllUsers', function (req, res) {
    db.query('SELECT * FROM bruger', function (err, rows) {
        if (err) {
            console.log(`fejl: ${err}`)
            console.log(rows);
            res.send(err)
        } else {
            res.send(rows)
        }
    })
})

}
```
**index.html** i en anden applikation evt. afviklet med *Live Server*
```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<body>

    <script>
        fetch('http://localhost:3333/getUser')
            .then(function (result) {
                return result.json();
            })
            .then(function(data) {
                console.log(data.firstname);
            })
    </script>
</body>

</html>
```