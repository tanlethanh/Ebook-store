const express = require('express')
const {
    addNewCartItem
} = require('../models/books')


router = express.Router()

const defaultUserId = 'f58d2683-7921-11ed-83a1-b445062d2ff3'
const defaultCartId = '9b0d2f5c-7924-11ed-83a1-b445062d2ff3'

module.exports = router.post('/cart', async(req, res) => {
    try {
        console.log(req.body)
        const result = await addNewCartItem(String(req.body.bookId), defaultCartId, 1)
        res.json({
            'type': 'success',
            'message': 'Add to cart successfully!'
        })
    } catch (error) {
        res.status(400).json({
            'type': 'warning',
            'message': error.sqlMessage
        })
    }
})