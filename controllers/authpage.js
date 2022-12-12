const {
    registerUser
} = require('../models/users')

exports.registerNewUser = async (req, res) => {
    const username = String(req.body.username)
    const password = String(req.body.password)
    const name = String(req.body.name)
    const email = String(req.body.email)
    const phone_number = String(req.body.phone_number)
    const birthday = String(req.body.birthday)
    const gender = String(req.body.gender)
    try {
        result = await registerUser(username, password, name, email, phone_number, birthday, gender)
        res.json({
            'type': 'success',
            'message': 'Add to cart successfully!'
        })
    }
    catch (error) {
        res.status(400).json({
            'type': 'warning',
            'message': error.sqlMessage
        })
    }
}

exports.renderRegisterPage = async (req, res) => {
    res.render('auth_register')
}

