const express = require('express')
const app = express()
const homeRoute = require('./routes/home')
const apiRoute = require('./routes/api')
const database = require('./models/connection')
const bodyParser = require('body-parser')

require('dotenv').config()
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + "/static"))
app.use(bodyParser.json())

database.connect()

app.use('/', homeRoute)

app.use('/api', apiRoute)


const PORT = 3000 || process.env.SERVER_PORT
app.listen(PORT, (error) => {
    if (error) console.log(error)
    else console.log(`App listening on port ${PORT}`)
})