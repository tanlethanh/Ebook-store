const express = require('express')
const { renderHomepage, renderHomeWithFilter, renderCart } = require('../controllers/homepage')

router = express.Router()

module.exports = router
    .get('/', renderHomepage)
    .get('/home/:cname/:scid', renderHomeWithFilter)
    .get('/home/:cname', renderHomeWithFilter)
    .get('/cart', renderCart)
    .get('/temp', (req, res) => {
        res.render('temp')
    })