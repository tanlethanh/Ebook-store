const { getAllBooks, getAllCategories } = require('../models/books')

exports.renderHomepage = async (req, res) => {
    const books = await getAllBooks()
    const categories = await getAllCategories()
    res.render('home', { books: books, categories: categories })
}
