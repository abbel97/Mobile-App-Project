const { query, run } = require('../database');

const profQuery = (where, params) => query(
  `SELECT p.*, u.name, u.email
   FROM professionals p
   JOIN users u ON u.id = p.user_id
   ${where}`,
  params
);

function getProfessionals(req, res) {
  try {
    return res.json(profQuery('ORDER BY p.created_at DESC', []));
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function getProfessional(req, res) {
  try {
    const { id } = req.params;
    const rows = profQuery('WHERE p.id = ? OR p.user_id = ?', [id, id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Professional not found' });
    return res.json(rows[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function getMyProfile(req, res) {
  try {
    const rows = profQuery('WHERE p.user_id = ?', [req.user.id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Profile not found' });
    return res.json(rows[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function updateProfessional(req, res) {
  try {
    const { id } = req.params;
    const rows = query(
      'SELECT * FROM professionals WHERE id = ? OR user_id = ?', [id, id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Professional not found' });
    if (rows[0].user_id !== req.user.id)
      return res.status(403).json({ message: 'Access denied' });

    const p   = rows[0];
    const now = new Date().toISOString();
    const {
      name, profession, bio, location,
      experience_years, service_rate, education_level,
      skills, photo_base64,
    } = req.body;

    run(
      `UPDATE professionals SET
        profession=?, bio=?, location=?,
        experience_years=?, service_rate=?, education_level=?,
        skills=?, photo_base64=?, updated_at=?
      WHERE id=?`,
      [
        profession      ?? p.profession,
        bio             !== undefined ? bio             : p.bio,
        location        !== undefined ? location        : p.location,
        experience_years !== undefined ? experience_years : p.experience_years,
        service_rate    !== undefined ? service_rate    : p.service_rate,
        education_level !== undefined ? education_level : p.education_level,
        skills          !== undefined ? skills          : p.skills,
        photo_base64    !== undefined ? photo_base64    : p.photo_base64,
        now, p.id,
      ]
    );

    if (name) run('UPDATE users SET name = ? WHERE id = ?', [name, req.user.id]);

    return res.json(profQuery('WHERE p.id = ?', [p.id])[0]);
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

function deleteProfessional(req, res) {
  try {
    const { id } = req.params;
    const rows = query(
      'SELECT * FROM professionals WHERE id = ? OR user_id = ?', [id, id]);
    if (rows.length === 0)
      return res.status(404).json({ message: 'Professional not found' });
    if (rows[0].user_id !== req.user.id)
      return res.status(403).json({ message: 'Access denied' });
    run('DELETE FROM professionals WHERE id = ?', [rows[0].id]);
    return res.json({ message: 'Profile deleted' });
  } catch { return res.status(500).json({ message: 'Server error' }); }
}

module.exports = {
  getProfessionals, getProfessional, getMyProfile,
  updateProfessional, deleteProfessional,
};