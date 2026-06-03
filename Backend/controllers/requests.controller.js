const crypto = require('crypto');
const { query, run } = require('../database');


function getRequests(req, res) {
  try {
    const { id, role } = req.user;
    const rows = role === 'customer'
      ? query(
          'SELECT * FROM service_requests WHERE customer_id = ? ORDER BY created_at DESC',
          [id]
        )
      : query(
          `SELECT * FROM service_requests
           WHERE status = 'pending' OR accepted_by = ?
           ORDER BY created_at DESC`,
          [id]
        );
    return res.json(rows);
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

// GET /api/requests/:id
function getRequest(req, res) {
  try {
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Request not found' });
    return res.json(rows[0]);
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

// POST /api/requests  (customer only)
function createRequest(req, res) {
  try {
    const { title, description, profession, location, urgency = 'regular', photo_base64 } = req.body;
    if (!title || !description || !profession || !location)
      return res.status(400).json({
        message: 'title, description, profession and location are required',
      });

    const id  = crypto.randomUUID();
    const now = new Date().toISOString();
    const customer = query('SELECT name FROM users WHERE id = ?', [req.user.id]);
    const customerName = customer[0]?.name || '';
    run(
      `INSERT INTO service_requests
         (id, title, description, profession, location, customer_name, status, urgency, customer_id, photo_base64, created_at, updated_at)
       VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
      [id, title, description, profession, location, customerName, 'pending', urgency, req.user.id, photo_base64 || null, now, now]
    );
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [id]);
    return res.status(201).json(rows[0]);
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

// PUT /api/requests/:id  (customer only, only if pending)
function updateRequest(req, res) {
  try {
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Request not found' });

    const r = rows[0];
    if (r.customer_id !== req.user.id)
      return res.status(403).json({ message: 'Access denied' });
    if (r.status !== 'pending')
      return res.status(400).json({ message: 'Only pending requests can be edited' });

    const { title, description, profession, location, urgency } = req.body;
    const now = new Date().toISOString();
    run(
      `UPDATE service_requests SET
         title       = COALESCE(?, title),
         description = COALESCE(?, description),
         profession  = COALESCE(?, profession),
         location    = COALESCE(?, location),
         urgency     = COALESCE(?, urgency),
         updated_at  = ?
       WHERE id = ?`,
      [
        title       ?? null,
        description ?? null,
        profession  ?? null,
        location    ?? null,
        urgency     ?? null,
        now,
        req.params.id,
      ]
    );
    const updated = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    return res.json(updated[0]);
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

// DELETE /api/requests/:id  (customer only, only if pending)
function deleteRequest(req, res) {
  try {
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Request not found' });

    const r = rows[0];
    if (r.customer_id !== req.user.id)
      return res.status(403).json({ message: 'Access denied' });
    if (r.status !== 'pending')
      return res.status(400).json({ message: 'Only pending requests can be deleted' });

    run('DELETE FROM service_requests WHERE id = ?', [req.params.id]);
    return res.json({ message: 'Request deleted' });
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

// PUT /api/requests/:id/accept  (professional only)
function acceptRequest(req, res) {
  try {
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Request not found' });

    const r = rows[0];
    if (r.status !== 'pending')
      return res.status(400).json({ message: 'Request is no longer available' });

    const now = new Date().toISOString();
    run(
      `UPDATE service_requests
       SET status = 'accepted', accepted_by = ?, updated_at = ?
       WHERE id = ?`,
      [req.user.id, now, req.params.id]
    );
    const updated = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    return res.json(updated[0]);
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

module.exports = {
  getRequests, getRequest,
  createRequest, updateRequest, deleteRequest,
  acceptRequest,
};