const express = require('express')
const app = express()
const homeRoute = require('./routes/home')
const bagRoute = require('./routes/bag')
const authRoute = require('./routes/register')
const database = require('./models/connection')

require('dotenv').config()
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + "/static"))

database.connect()

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/', homeRoute)

app.use('/', bagRoute)

app.use('/', authRoute)

const PORT = 3000 || process.env.SERVER_PORT
app.listen(PORT, (error) => {
    if (error) console.log(error)
    else console.log(`App listening on port ${PORT}`)
})