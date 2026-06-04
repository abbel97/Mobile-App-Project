const express = require('express');
const router  = express.Router();
const { authenticate, authorize } = require('../middleware/auth.middleware');
const {
  createRequest, getRequests, getRequest,
  updateRequest, deleteRequest, acceptRequest,
  applyRequest, confirmRequest, rejectApplicant,
} = require('../controllers/requests.controller');

router.use(authenticate);

router.get('/',       getRequests);
router.get('/:id',   getRequest);
router.post('/',      authorize('customer'), createRequest);
router.put('/:id',    authorize('customer'), updateRequest);
router.delete('/:id', authorize('customer'), deleteRequest);
router.put('/:id/accept',  authorize('professional'), acceptRequest);
router.put('/:id/apply',           authorize('professional'), applyRequest);    
router.put('/:id/confirm',         authorize('customer'), confirmRequest);  
router.put('/:id/reject-applicant',authorize('customer'),  rejectApplicant); 

module.exports = router;