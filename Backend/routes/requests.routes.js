const express = require('express');
const router  = express.Router();
const { authenticate, authorize } = require('../middleware/auth.middleware');
const {
  createRequest, getRequests, getRequest,
  updateRequest, deleteRequest, acceptRequest,
} = require('../controllers/requests.controller');

router.use(authenticate);

router.get('/',  getRequests);
router.get('/:id',  getRequest);
router.post('/', authorize('customer'), createRequest);
router.put('/:id', authorize('customer'), updateRequest);
router.delete('/:id', authorize('customer'), deleteRequest);
router.put('/:id/accept',  authorize('professional'), acceptRequest);

module.exports = router;