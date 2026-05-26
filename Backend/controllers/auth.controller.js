const bcrypt = require('bcryptjs');
const jwt    = require('jsonwebtoken');
const crypto = require('crypto');
const { query, run } = require('../database');

const sign = (id, role) =>
  jwt.sign({ id, role }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });

async function registerCustomer(req, res) {
  try {
    const { name, email, password } = req.body;
    if (!name || !email || !password)
      return res.status(400).json({ message: 'Name, email and password are required' });

    if (query('SELECT id FROM users WHERE email = ?', [email]).length > 0)
      return res.status(409).json({ message: 'Email already in use' });

    const id  = crypto.randomUUID();
    const now = new Date().toISOString();
    run(
      'INSERT INTO users (id, name, email, password, role, created_at) VALUES (?,?,?,?,?,?)',
      [id, name, email, await bcrypt.hash(password, 10), 'customer', now]
    );

    return res.status(201).json({
      token: sign(id, 'customer'),
      user:  { id, name, email, role: 'customer', created_at: now },
    });
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

async function registerProfessional(req, res) {
  try {
    const {
      name, email, password, profession,
      bio, location, experience_years, service_rate, education_level,
    } = req.body;

    if (!name || !email || !password || !profession)
      return res.status(400).json({ message: 'Name, email, password and profession are required' });

    if (query('SELECT id FROM users WHERE email = ?', [email]).length > 0)
      return res.status(409).json({ message: 'Email already in use' });

    const userId = crypto.randomUUID();
    const profId = crypto.randomUUID();
    const now    = new Date().toISOString();

    run(
      'INSERT INTO users (id, name, email, password, role, created_at) VALUES (?,?,?,?,?,?)',
      [userId, name, email, await bcrypt.hash(password, 10), 'professional', now]
    );
    run(
      `INSERT INTO professionals
         (id, user_id, name, email, profession, bio, location,
          experience_years, service_rate, education_level, created_at, updated_at)
       VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
      [profId, userId, name, email, profession,
       bio || '', location || '', experience_years || 0,
       service_rate || 0, education_level || '', now, now]
    );

    return res.status(201).json({
      token: sign(userId, 'professional'),
      user:  { id: userId, name, email, role: 'professional', created_at: now },
    });
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

async function login(req, res) {
  try {
    const { email, password } = req.body;
    if (!email || !password)
      return res.status(400).json({ message: 'Email and password are required' });

    const users = query('SELECT * FROM users WHERE email = ?', [email]);
    if (users.length === 0 || !(await bcrypt.compare(password, users[0].password)))
      return res.status(401).json({ message: 'Invalid email or password' });

    const { id, name, role, created_at } = users[0];
    return res.json({
      token: sign(id, role),
      user:  { id, name, email, role, created_at },
    });
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

async function deleteAccount(req, res) {
  try {
    const { id, role } = req.user;
    run('DELETE FROM service_requests WHERE customer_id = ?', [id]);
    if (role === 'professional') run('DELETE FROM professionals WHERE user_id = ?', [id]);
    run('DELETE FROM users WHERE id = ?', [id]);
    return res.json({ message: 'Account deleted' });
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

async function changePassword(req, res) {
  try {
    const { currentPassword, newPassword } = req.body;
    if (!currentPassword || !newPassword)
      return res.status(400).json({ message: 'Both passwords are required' });

    const users = query('SELECT * FROM users WHERE id = ?', [req.user.id]);
    if (!(await bcrypt.compare(currentPassword, users[0].password)))
      return res.status(401).json({ message: 'Current password is incorrect' });

    run('UPDATE users SET password = ? WHERE id = ?',
      [await bcrypt.hash(newPassword, 10), req.user.id]);
    return res.json({ message: 'Password changed successfully' });
  } catch {
    return res.status(500).json({ message: 'Server error' });
  }
}

module.exports = { registerCustomer, registerProfessional, login, deleteAccount, changePassword };