const mysql = require('mysql2')

const db = mysql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'bb'
});

const host = "http://localhost:3333";
const version = "/api/v1";

function routeAccessCheck(req, res, next) {
    if (!req.headers.authorization || req.headers.authorization !== "1234") {
        res.status(401).end();
        return;
    }

    next();
}

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

    app.use(routeAccessCheck);

    app.get(version + '/products', function (req, res) {
        db.query(sql, function (err, rows) {
            if (err) {
                return res.send(err);
            } else {
                let obj = {};
                obj.data = rows;
                obj.url = host + version + "/products";
                res.send(obj);
            }
        });
    });

    app.get('/products/:id', function (req, res) {

        db.query(sqlSingle, [req.params.id], function (err, rows) {

            if (err) {
                res.send(err)
            } else {
                res.send(rows)
            }
        })
    })

    app.get("/farve", function(req, res) {
        let sql = "SELECT id, navn FROM farve"

        db.query(sql, function(err, rows) {
            if (err) throw new Error(err)

            res.send(rows)
        })
    })

    app.get("/styrke", function(req, res) {
        let sql = "SELECT id, navn FROM styrke"

        db.query(sql, function(err, rows) {
            if (err) throw new Error(err)

            res.send(rows)
        })
    })

    app.get("/smag", function(req, res) {
        let sql = "SELECT id, navn FROM smag"

        db.query(sql, function(err, rows) {
            if (err) throw new Error(err)

            res.send(rows)
        })
    })

    app.get("/surhed", function(req, res) {
        let sql = "SELECT id, navn FROM surhed"

        db.query(sql, function(err, rows) {
            if (err) throw new Error(err)

            res.send(rows)
        })
    })

    app.post("/products", function(req, res) {
        let sql = `INSERT INTO bolche
                    SET navn = ?,
                    pris = ?,
                    vaegt = ?,
                    fk_smag = ?,
                    fk_surhed = ?,
                    fk_styrke = ?,
                    fk_farve = ?`;

        db.query(sql, [req.body.navn, req.body.pris,
                       req.body.vaegt, req.body.fk_smag,
                       req.body.fk_surhed, req.body.fk_styrke,
                       req.body.fk_farve], function(err, result) {
            if (err) throw new Error(err);

            res.status(201).end();
        });
    });

    app.post("/farve", function(req, res) {
        let sql = "INSERT INTO farve SET navn = ?";

        db.query(sql, [req.body.navn], function(err, result) {
            if (err) {
                console.log(err);
                res.status(500).end();
                return;
            }

            res.status(201).end();
        });
    });

}

