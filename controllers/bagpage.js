const {getAllBooks} = require('../models/bags')

exports.renderBagpage = async (req, res) => {
    const books = await getAllBooks()
    res.render('bag', { books: books})
}
