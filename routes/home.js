const express = require('express')
const { renderHomepage, renderHomeWithFilter } = require('../controllers/homepage')

router = express.Router()

module.exports = router
    .get('/', renderHomepage)

module.exports = router
    .get('/home/:cname/:scid', renderHomeWithFilter)

module.exports = router
    .get('/home/:cname', renderHomeWithFilter)