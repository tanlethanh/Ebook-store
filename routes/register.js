const express = require('express')
const { renderRegisterPage, registerNewUser } = require('../controllers/authpage')

router = express.Router()

module.exports = router
    .post('/register', registerNewUser)
    .get('/register', renderRegisterPage)
