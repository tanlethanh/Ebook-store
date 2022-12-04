const express = require('express')
const { renderBagpage } = require('../controllers/bagpage')

router = express.Router()

module.exports = router
    .get('/bag', renderBagpage)


