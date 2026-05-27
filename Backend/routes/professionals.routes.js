const express = require('express');
const router  = express.Router();
const { authenticate, authorize } = require('../middleware/auth.middleware');
const {
	listProfessionals,
	getProfessionalById,
	getMyProfile,
	updateMyProfile,
} = require('../controllers/professionals.controller');

router.use(authenticate);

router.get('/', listProfessionals);
router.get('/me', authorize('professional'), getMyProfile);
router.put('/me', authorize('professional'), updateMyProfile);
router.get('/:professionalId', getProfessionalById);

module.exports = router;