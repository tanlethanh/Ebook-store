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
                        id: ele.spec_id,
                        numBooks: ele.num_books
                    }
                    if (!cate_dict[ele.root_category]) {
                        cate_dict[ele.root_category] = {
                            name: ele.root_category,
                            specificCategories: [new_obj]
                        }
                    }
                    else {
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
            if (error) {
                reject(error)
            }
            resolve(results)
        });
    })

}