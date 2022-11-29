var mysql = require('mysql');
require('dotenv').config()
console.log
var connection = mysql.createConnection({
    host: process.env.DATABASE_HOST,
    user: process.env.USERNAME,
    password: process.env.PASSWORD,
    database: process.env.DATABASE_NAME
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
    if (error) throw error;
    console.log('The solution is: ', results[0].solution);
});

connection.end();