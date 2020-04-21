const mysql = require('mysql2')

const db = mysql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'bb'
});

module.exports = function (app) {
    const sql = `SELECT 
            
        bolche.id as 'id',
        bolche.navn as 'navn',
        bolche.pris as 'pris',
        bolche.vaegt as 'vaegt',
        surhed.navn as 'surhed',
        smag.navn as 'smag',
        styrke.navn as 'styrke',
        farve.navn as 'farve'

            FROM bolche 

            inner join surhed on bolche.fk_surhed = surhed.id
            inner join smag on bolche.fk_smag = smag.id
            inner join styrke on bolche.fk_styrke = styrke.id
            inner join farve on bolche.fk_farve = farve.id`

    const sqlSingle = sql + ' WHERE bolche.id = ?'


    app.get('/products', function (req, res) {
        db.query(sql, function (err, rows) {
            if (err) {
                res.send(err)
            } else {
                res.send(rows)
            }
        })
    })

    app.get('/products/:id', function (req, res) {

        db.query(sqlSingle, [req.params.id], function (err, rows) {

            if (err) {
                res.send(err)
            } else {
                res.send(rows)
            }
        })
    })

    app.get('/', function (req, res) {
        res.send("Tekst fra et route")
    })

    app.get('/test', function (req, res) {
        res.send("Dette er en test")
    })

    app.get('/author', function (req, res) {
        let user = {
            "firstname": "Frank",
            "lastname": "Goldmann"
        }
        res.send(user)
    })

}