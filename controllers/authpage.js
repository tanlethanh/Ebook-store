const {
    registerUser
} = require('../models/user')

exports.registerNewUser = async (req, res) => {
    const username = String(req.body.username)
    const password = String(req.body.password)
    const name = String(req.body.name)
    const email = String(req.body.email)
    const phone_number = String(req.body.phone_number)
    const birthday = String(req.body.birthday)
    const gender = String(req.body.gender)
    result = await registerUser(username, password, name, email, phone_number, birthday, gender)
    console.log(result)
}

exports.renderRegisterPage = async (req, res) => {
    res.render('auth_register')
}

