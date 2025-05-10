const express = require('express');
const authRouter = express.Router();
const { validateRegistration, validateLogin } = require('../middleware/validator');
const { register, login } = require('../controllers/authController');

//* Register route
authRouter.post('/register', validateRegistration, register);

//* Login route
authRouter.post('/login', validateLogin, login);

module.exports = authRouter;