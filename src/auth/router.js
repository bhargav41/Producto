const {Router} = require('express');
const login = require('./login');
const signup = require('./signup');
const validateToken = require('./validate');

const router = Router();

router.post('/login', login);
router.post('/signup', signup);
router.get('/validate', validateToken);

module.exports = router;