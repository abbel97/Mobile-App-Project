const crypto = require('crypto');
const { query, run } = require('../database');

function createRequest(req, res) {
  try {
    const { title, description, profession, location, urgency } = req.body;
    if (!title || !description || !profession || !location)
      return res.status(400).json({ message: 'Title, description, profession and location are required' });

    const id  = crypto.randomUUID();
    const now = new Date().toISOString();

    run(
      `INSERT INTO service_requests
         (id, title, description, profession, location, status, urgency, customer_id, created_at, updated_at)
       VALUES (?,?,?,?,?,'pending',?,?,?,?)`,
      [id, title, description, profession, location, urgency || 'regular', req.user.id, now, now]
    );

    return res.status(201).json(query('SELECT * FROM service_requests WHERE id = ?', [id])[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function getRequests(req, res) {
  try {
    const { id, role } = req.user;
    const requests = role === 'customer'
      ? query('SELECT * FROM service_requests WHERE customer_id = ? ORDER BY created_at DESC', [id])
      : query(`SELECT * FROM service_requests WHERE status = 'pending' OR accepted_by = ? ORDER BY created_at DESC`, [id]);
    return res.json(requests);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function getRequest(req, res) {
  try {
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ message: 'Request not found' });
    return res.json(rows[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function updateRequest(req, res) {
  try {
    const { id } = req.params;
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [id]);
    if (rows.length === 0)    
        return res.status(404).json({ message: 'Request not found' });
    if (rows[0].customer_id !== req.user.id) 
      return res.status(403).json({ message: 'Access denied' });
    if (rows[0].status !== 'pending')    
        return res.status(400).json({ message: 'Only pending requests can be edited' });

    const r   = rows[0];
    const now = new Date().toISOString();
    const { title, description, profession, location, urgency } = req.body;

    run(
      `UPDATE service_requests SET title=?, description=?, profession=?, location=?, urgency=?, updated_at=? WHERE id=?`,
      [title||r.title, description||r.description, profession||r.profession, location||r.location, urgency||r.urgency, now, id]
    );
    return res.json(query('SELECT * FROM service_requests WHERE id = ?', [id])[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function deleteRequest(req, res) {
  try {
    const { id } = req.params;
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Request not found' });
    if (rows[0].customer_id !== req.user.id) 
      return res.status(403).json({ message: 'Access denied' });
    run('DELETE FROM service_requests WHERE id = ?', [id]);
    return res.json({ message: 'Request deleted' });
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function acceptRequest(req, res) {
  try {
    const { id } = req.params;
    const rows = query('SELECT * FROM service_requests WHERE id = ?', [id]);
    if (rows.length === 0)         
      return res.status(404).json({ message: 'Request not found' });
    if (rows[0].status !== 'pending') 
      return res.status(400).json({ message: 'Request no longer available' });

    const now = new Date().toISOString();
    run(`UPDATE service_requests SET status='accepted', accepted_by=?, updated_at=? WHERE id=?`,
      [req.user.id, now, id]);
    return res.json(query('SELECT * FROM service_requests WHERE id = ?', [id])[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

module.exports = { createRequest, getRequests, getRequest, updateRequest, deleteRequest, acceptRequest };