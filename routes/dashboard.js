const express = require('express')
const { renderUserDashboard, CRUDUserDashboard} = require('../controllers/dashboard')

router = express.Router()

module.exports = router
    .get('/user', renderUserDashboard)
    .post('/user', CRUDUserDashboard)