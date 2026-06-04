const { query, run } = require('../database');

function getNotifications(req, res) {
  try {
    const rows = query(
      `SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC`,
      [req.user.id]
    );
    return res.json(rows);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function markAsRead(req, res) {
  try {
    run('UPDATE notifications SET is_read = 1 WHERE id = ? AND user_id = ?',
      [req.params.id, req.user.id]);
    return res.json({ message: 'Marked as read' });
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function markAllRead(req, res) {
  try {
    run('UPDATE notifications SET is_read = 1 WHERE user_id = ?', [req.user.id]);
    return res.json({ message: 'All marked as read' });
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

module.exports = { getNotifications, markAsRead, markAllRead };