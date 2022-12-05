const database = require('./connection')

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