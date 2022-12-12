const express = require('express')
const {
    addNewCartItem,
    deleteCartItemByCartIdAndBookId
} = require('../models/books')


router = express.Router()

const defaultUserId = 'f58d2683-7921-11ed-83a1-b445062d2ff3'
const defaultCartId = '9b0d2f5c-7924-11ed-83a1-b445062d2ff3'

router
    .post('/cart', async(req, res) => {
        try {
            console.log(req.body)
            const result = await addNewCartItem(String(req.body.bookId), defaultCartId, 1)
            return res.json({
                'type': 'success',
                'message': 'Add to cart successfully!'
            })
        } catch (error) {
            return res.status(400).json({
                'type': 'warning',
                'message': error.sqlMessage
            })
        }
    })
    .post('/cart/item', async(req, res) => {
        const action = req.body.action
        const cartId = req.body.cartId
        const bookId = req.body.bookId

        console.log("Post api: cart item ", req.body)

        if (!action || !cartId || !bookId) {
            return res.status(400).json({
                'type': 'error',
                message: "Invalid fields, require action, cartId, bookId"
            })
        }
        console.log
        switch (action) {
            case 'DELETE':
                console.log("Delete cart item")
                const result = await deleteCartItemByCartIdAndBookId(cartId, bookId)
                return res.json({
                    'type': 'success',
                    message: "Reload require!"
                })
        }

    })

module.exports = router