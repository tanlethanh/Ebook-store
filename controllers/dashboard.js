const {
    getAllUser, registerManager, updateUser
} = require('../models/users')

exports.renderUserDashboard = async (req, res) => {
    const users = await getAllUser()
    res.render('dashboard_user', { users: users })
}

exports.CRUDUserDashboard = async (req, res) => {
    try {
        const action = req.body.action
        console.log(action)
        if (action == "ADD") {
            result = await registerManager(req.body.username, req.body.password, req.body.name, req.body.email, req.body.phone_number, req.body.birthday, req.body.gender)
        }
        if (action == "UPDATE")
            result = await updateUser(req.body.preUsername, req.body.username, req.body.password, req.body.name, req.body.email, req.body.phone_number, req.body.birthday, req.body.gender)
        
            res.json({
            'type': 'success',
            'message': 'Make change successfully!'
        })
    } catch (error) {
        res.status(400).json({
            'type': 'warning',
            'message': error.sqlMessage
        })
    }
}