const database = require('./connection')

exports.registerUser = (username, password, name, email, phone_number, birthday, gender) => {
    return new Promise((resolve, reject) => {
        database.query(
            `INSERT INTO users(id,username,password,name,email,phone_number,birthday,gender) values('10','${username}','${password}','${name}','${email}','${phone_number}','${birthday}','${gender}')`,
            function (error, results, fields) {
                if (error) {
                    reject(error)
                }
                resolve("Them tai khoan thanh cong")
            })
    })

}
