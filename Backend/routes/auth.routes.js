const express = require('express');
const router  = express.Router();

const { authenticate } = require('../middleware/auth.middleware');
const {
  registerCustomer, registerProfessional,
  login, deleteAccount, changePassword,
} = require('../controllers/auth.controller');

router.post('/register/customer',     registerCustomer);
router.post('/register/professional', registerProfessional);
router.post('/login',                 login);
router.delete('/account',             authenticate, deleteAccount);
router.put('/change-password',        authenticate, changePassword);

module.exports = router;