const express = require('express')
const { renderHomepage } = require('../controllers/homepage')

router = express.Router()

module.exports = router
    .get('/', renderHomepage)


