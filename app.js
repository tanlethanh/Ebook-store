const express = require('express')
const app = express()
const homeRoute = require('./routes/home')
const database = require('./models/connection')

require('dotenv').config()
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + "/static"))

database.connect()

app.use('/', homeRoute)



const PORT = 3000 || process.env.SERVER_PORT
app.listen(PORT, (error) => {
    if (error) console.log(error)
    else console.log(`App listening on port ${PORT}`)
})