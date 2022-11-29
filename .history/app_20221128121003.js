const express = require('express')
const mysql = require('mysql');
const app = express()
require('dotenv').config()
app.set('view engine', 'ejs');

const connection = mysql.createConnection({
    host: process.env.DATABASE_HOST,
    user: process.env.DATABASE_USERNAME,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE_NAME
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
    if (error) throw error;
    console.log('The solution is: ', results[0].solution);
});

connection.end();

const PORT = 3000 || process.env.SERVER_PORT
app.listen(PORT, (error) => {
    if (error) console.log(error)
    else console.log(`App listening on port ${PORT}`)
})