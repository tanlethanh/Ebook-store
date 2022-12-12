const express = require('express')
const {
    addNewCartItem,
    deleteCartItemByCartIdAndBookId,
    updateBook,
    getBookById,
    deleteBookById,
    insertBook
} = require('../models/books')


router = express.Router()

const defaultUserId = 'f58d2683-7921-11ed-83a1-b445062d2ff3'
const defaultCartId = '9b0d2f5c-7924-11ed-83a1-b445062d2ff3'

router
    .post('/cart', async (req, res) => {
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
    .post('/cart/item', async (req, res) => {
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
    .post('/cart', async (req, res) => {
        try {
            //console.log(req.body)
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
    .post('/book/:action', async (req, res) => {
        try {
            let result;
            const action = req.params.action
            if (action === 'update') {
                //console.log(req.body)
                result = await updateBook(
                    String(req.body.id),
                    String(req.body.name),
                    String(req.body.price),
                    String(req.body.discount),
                    String(req.body.quantity),
                    String(req.body.img),
                )
                res.json({
                    'type': 'success',
                    'message': 'Update successfully!'
                })
            }
            else if (action === 'read') {
                result = await getBookById(String(req.body.id))
                res.json(result)
            }
            else if (action === 'delete') {
                result = await deleteBookById(String(req.body.id))
                res.json({
                    'type': 'success',
                    'message': (result === 'success') ?
                        'Xoá sách thành công!' :
                        'Không thể xoá sách do đơn sách đã được khởi tạo/ chấp nhận thanh toán/ vận chuyển!'
                })
            }
            if (action === 'create') {
                console.log(req.body)
                result = await insertBook(
                    String(req.body.name),
                    String(req.body.price),
                    String(req.body.discount),
                    String(req.body.quantity),
                    String(req.body.img),
                    String(req.body.sc),
                )
                res.json({
                    'type': 'success',
                    'message': 'Add successfully!'
                })
            }

        } catch (error) {
            res.status(400).json({
                'type': 'warning',
                'message': error.sqlMessage
            })
        }
    })

module.exports = router
