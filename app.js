const express = require('express');
const app = express();
const cors = require("cors");
const bodyParser = require("body-parser");

app.use(cors());
app.use(bodyParser.json());

app.use(express.static("docs"));

require('./routes/index')(app);


app.listen(3333);
console.log(`Serveren er startet på http://localhost:3333`);