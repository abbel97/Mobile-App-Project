const express = require('express');
const router  = express.Router();

const { authenticate } = require('../middleware/auth.middleware');
const {
  registerCustomer, registerProfessional,
  login, deleteAccount, changePassword, updateMe, resetPassword,
} = require('../controllers/auth.controller');

router.post('/register/customer',     registerCustomer);
router.post('/register/professional', registerProfessional);
router.post('/login',                 login);
router.put('/me',                     authenticate, updateMe);
router.delete('/account',             authenticate, deleteAccount);
router.put('/change-password',        authenticate, changePassword);
router.post('/reset-password',        resetPassword);

module.exports = router;