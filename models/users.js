const database = require('./connection')

exports.registerUser = (username, password, name, email, phone_number, birthday, gender) => {
    return new Promise((resolve, reject) => {
        database.query(
            `call insert_user_with_cart('${username}','${password}','CUSTOMER','${name}','${email}','${phone_number}','${birthday}','${gender}')`,
            function (error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve("Them tai khoan khách hàng thanh cong")
            })
    })
}

exports.registerManager = (username, password, name, email, phone_number, birthday, gender) => {
    return new Promise((resolve, reject) => {
        database.query(
            `call insert_user_with_cart('${username}','${password}','MANAGER','${name}','${email}','${phone_number}','${birthday}','${gender}')`,
            function (error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve("Them tai khoan quản lý thanh cong")
            })
    })
}

exports.updateUser = (pre_username, username, password, name, email, phone_number, birthday, gender) => {
    return new Promise((resolve, reject) => {
        database.query(
            `Update users SET username = '${username}', password = '${password}', name = '${name}', email = '${email}', phone_number = '${phone_number}',  birthday= '${birthday}', gender = '${gender}', where username = '${pre_username}',;`,
            function (error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve("Them tai khoan quản lý thanh cong")
            })
    })
}

exports.getAllUser = () => {
    return new Promise((resolve, reject) => {
        database.query(
            `SELECT * FROM users`,
            function (error, result, fields) {
                if (error) {
                    reject(error)
                }
                resolve(result)
            }
        )
    }

    )
}
