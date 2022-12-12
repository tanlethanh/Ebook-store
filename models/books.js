const database = require('./connection')

exports.getAllCategories = () => {
    return new Promise((resolve, reject) => {
        database.query(
            `SELECT c.name as root_category, sc.name as spec_category, sc.id as specific_category_id, count(b.id) as num_books
            FROM categories AS c 
            INNER JOIN specificcategories as sc ON c.id = sc.category_id
            LEFT JOIN books as b ON b.specific_category_id = sc.id
            GROUP BY root_category, spec_category`,
            function(error, results, fields) {
                if (error) reject(error)
                cate_dict = {}
                results.forEach(ele => {
                    const new_obj = {
                        name: ele.spec_category,
                        id: ele.specific_category_id,
                        numBooks: ele.num_books
                    }
                    if (!cate_dict[ele.root_category]) {
                        cate_dict[ele.root_category] = {
                            name: ele.root_category,
                            specificCategories: [new_obj]
                        }
                    } else {
                        cate_dict[ele.root_category].specificCategories.push(new_obj)
                    }
                });
                resolve(Object.values(cate_dict))
            })
    })
}

exports.getAllBooks = () => {
    return new Promise((resolve, reject) => {
        database.query('SELECT * FROM BOOKS', function(error, results, fields) {
            if (error) {
                reject(error)
            }
            resolve(results)
        });
    })

}

exports.getBooksBySpecCategoryId = (id) => {
    return new Promise((resolve, reject) => {
        database.query(`SELECT * FROM BOOKS WHERE specific_category_id='${id}'`, function(error, results, fields) {
            if (error) {
                reject(error)
            }
            resolve(results)
        });
    });
}

exports.getSpecCategoryNameById = (id) => {
    return new Promise((resolve, reject) => {
        database.query(`SELECT * FROM SpecificCategories WHERE id='${id}'`, function(error, results, fields) {
            if (error) {
                reject(error)
            }
            resolve(results)
        });
    });
}

exports.getBooksByCategoryName = (name) => {
    return new Promise((resolve, reject) => {
        database.query(`
            SELECT * FROM 
            Books as b, Categories as c 
            WHERE b.category_id = c.id and c.name='${name}'`,
            function(error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve(results)
            }
        );
    });
}

exports.addNewCartItem = (book_id, cart_id, quantity) => {
    return new Promise((resolve, reject) => {
        database.query(`INSERT INTO CartItems (book_id, cart_id, quantity)
            VALUES ('${book_id}', '${cart_id}', ${quantity})`,
            function(error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve(results)
            })

    })
}

exports.getCartItemsByCartId = (cart_id) => {
    return new Promise((resolve, reject) => {
        database.query(`SELECT b.name as bookName, b.id as bookId, 
        b.quantity as curQuantity, ci.quantity as quantity, b.price as price, 
        b.discount as discount,
        caculate_total_price(b.discount, b.price) as totalPrice, 
        b.main_image_url as imageUrl
        FROM cartitems AS ci
        LEFT JOIN books as b ON ci.book_id = b.id
        WHERE ci.cart_id = '${cart_id}' and ci.state = 'NOW'`,
            function(error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve(results)
            })
    })
}

exports.deleteCartItemByCartIdAndBookId = (cart_id, book_id) => {
    return new Promise((resolve, reject) => {
        database.query(`delete from cartitems 
        WHERE cart_id = '${cart_id}' and book_id = '${book_id}'`,
            function(error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve(results)
            })
    })
}