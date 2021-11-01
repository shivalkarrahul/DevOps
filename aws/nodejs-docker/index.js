const express = require('express');
const app = express();
const port = 3000;
const mysql = require('mysql');
const con = mysql.createConnection({
    host: "CHANGE-ME",
    user: "CHANGE-ME",
    password: "CHANGE-ME"
});


app.get('/status', (req, res) => res.send({status: "I'm up and running"}));
app.listen(port, () => console.log(`Dockerized Nodejs Applications is listening on port ${port}!`));


app.post('/insert', (req, res) => {
    if (req.query.username && req.query.email && req.query.age) {
        console.log('Received an insert call');
        con.connect(function(err) {
            con.query(`INSERT INTO main.users (username, email, age) VALUES ('${req.query.username}', '${req.query.email}', '${req.query.age}')`, function(err, result, fields) {
                if (err) res.send(err);
                if (result) res.send({username: req.query.username, email: req.query.email, age: req.query.age});
                if (fields) console.log(fields);
            });
        });
    } else {
        console.log('Something went wrong, Missing a parameter');
    }
});



app.get('/list', (req, res) => {
    console.log('Received a list call');
    con.connect(function(err) {
        con.query(`SELECT * FROM main.users`, function(err, result, fields) {
            if (err) res.send(err);
            if (result) res.send(result);
        });
    });
});

