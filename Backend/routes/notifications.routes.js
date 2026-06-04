const express = require('express');
const router  = express.Router();
const { authenticate } = require('../middleware/auth.middleware');
const { getNotifications, markAsRead, markAllRead } = require('../controllers/notifications.controller');

router.use(authenticate);
router.get('/',         getNotifications);
router.put('/read-all', markAllRead);
router.put('/:id/read', markAsRead);

module.exports = router;