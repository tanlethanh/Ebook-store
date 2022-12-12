const e = require('express')
const database = require('./connection')

exports.getAllCategories = () => {
    return new Promise((resolve, reject) => {
        database.query(
            `SELECT c.name as root_category, sc.name as spec_category, sc.id as specific_category_id, count(b.id) as num_books
            FROM categories AS c 
            INNER JOIN specificcategories as sc ON c.id = sc.category_id
            LEFT JOIN books as b ON b.specific_category_id = sc.id
            GROUP BY root_category, spec_category`,
            function (error, results, fields) {
                if (error) reject(error)
                cate_dict = {}
                results.forEach(ele => {
                    const new_obj = {
                        name: ele.spec_category,
                        id: ele.specific_category_id,
                        numBooks: ele.num_books
                    }
                    if (!cate_dict[ele.root_category])
                    {
                        cate_dict[ele.root_category] = {
                            name: ele.root_category,
                            specificCategories: [new_obj]
                        }
                    } else
                    {
                        cate_dict[ele.root_category].specificCategories.push(new_obj)
                    }
                });
                resolve(Object.values(cate_dict))
            })
    })
}

exports.getAllBooks = () => {
    return new Promise((resolve, reject) => {
        database.query('SELECT * FROM BOOKS', function (error, results, fields) {
            if (error)
            {
                reject(error)
            }
            resolve(results)
        });
    })

}

exports.getBooksBySpecCategoryId = (id) => {
    return new Promise((resolve, reject) => {
        database.query(`SELECT * FROM BOOKS WHERE specific_category_id='${id}'`, function (error, results, fields) {
            if (error)
            {
                reject(error)
            }
            resolve(results)
        });
    });
}

exports.getSpecCategoryNameById = (id) => {
    return new Promise((resolve, reject) => {
        database.query(`SELECT * FROM SpecificCategories WHERE id='${id}'`, function (error, results, fields) {
            if (error)
            {
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
            function (error, results, fields) {
                if (error)
                {
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
            function (error, results, fields) {
                if (error)
                {
                    reject(error)
                }
                resolve(results)
            })

    })
}

exports.updateBook = (id, name, price, discount, quantity, img) => {

    // specific_category_id,
    // category_id,
    return new Promise((resolve, reject) => {
        database.query(`UPDATE BOOKS SET
            name='${name}',
            price=${price},
            discount=${discount},
            quantity=${quantity},
            main_image_url='${img}' WHERE id='${id}'`,
            function (error, results, fields) {
                if (error)
                {
                    reject(error)
                }
                resolve(results)
            })
    })
}

exports.getBookById = (id) => {
    return new Promise((resolve, reject) => {
        database.query(`
        SELECT * FROM Books as b
        JOIN (SELECT name as scname, id FROM SpecificCategories) AS sc ON 
	        b.specific_category_id=sc.id and b.id='${id}'`,
            function (error, results, fields) {
                if (error)
                {
                    reject(error)
                }
                resolve(results)
            }
        );
    });
}

exports.insertBook = (name, price, discount, quantity, img, sc) => {
    return new Promise((resolve, reject) => {
        database.query(`
        INSERT INTO Books (name, price, discount, quantity, main_image_url, specific_category_id)
        VALUES ('${name}', ${price}, ${discount}, ${quantity}, '${img}',
            (SELECT id FROM SpecificCategories WHERE name='${sc}')
        )`,
            function (error, results, fields) {
                if (error)
                {
                    reject(error)
                }
                resolve(results)
            }
        );
    });
}

exports.deleteBookById = (id) => {
    return new Promise((resolve, reject) => {
        database.query(`
        DELETE FROM Books WHERE id='${id}'
        AND id NOT IN 
            (SELECT ob.book_id 
            FROM OrderBooks AS ob, Orders AS o
            WHERE o.id = ob.order_id 
            AND (o.state='INIT' OR o.state='CONFIRM' OR o.state='SHIPPING'))`,
            function (error, results, fields) {
                if (error)
                {
                    reject(error)
                }

                //console.log('Changed row', results.changedRows)
                if (results.affectedRows === 0)
                {
                    resolve('failed')                    
                }
                else
                {
                    resolve('success')
                }
            }
        );
    });
}