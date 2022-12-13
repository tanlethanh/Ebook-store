const express = require('express')
const { renderHomepage, renderHomeWithFilter, renderCart, renderOrder } = require('../controllers/homepage')

router = express.Router()

module.exports = router
    .get('/', renderHomepage)
    .get('/home/:cname/:scid', renderHomeWithFilter)
    .get('/home/:cname', renderHomeWithFilter)
    .get('/cart/:cartId', renderCart)
    .get('/order/:orderId', renderOrder)