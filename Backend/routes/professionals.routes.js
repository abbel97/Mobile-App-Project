const express = require('express');
const router  = express.Router();
const { authenticate, authorize } = require('../middleware/auth.middleware');
const {
  getProfessionals, getProfessional, getMyProfile,
  updateProfessional, deleteProfessional,
} = require('../controllers/professionals.controller');

router.get('/',    authenticate,                          getProfessionals);
router.get('/me',  authenticate, authorize('professional'), getMyProfile);
router.get('/:id', authenticate,                          getProfessional);
router.put('/:id', authenticate, authorize('professional'), updateProfessional);
router.delete('/:id', authenticate, authorize('professional'), deleteProfessional);

module.exports = router;