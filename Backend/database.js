const initSqlJs = require('sql.js');
const fs = require('fs');
const path = require('path');

const DB_PATH = path.join(__dirname, 'home_tweak.db');
let db;

async function initDatabase() {
  const SQL = await initSqlJs();

  if (fs.existsSync(DB_PATH)) {
    const buffer = fs.readFileSync(DB_PATH);
    db = new SQL.Database(buffer);
  } else {
    db = new SQL.Database();
  }

  createTables();
  console.log('✅ Database ready');
}

function save() {
  fs.writeFileSync(DB_PATH, Buffer.from(db.export()));
}

function createTables() {
  db.run(`
    CREATE TABLE IF NOT EXISTS users (
      id         TEXT PRIMARY KEY,
      name       TEXT NOT NULL,
      email      TEXT NOT NULL UNIQUE,
      password   TEXT NOT NULL,
      role       TEXT NOT NULL CHECK(role IN ('customer','professional')),
      created_at TEXT NOT NULL
    )
  `);

  db.run(`
    CREATE TABLE IF NOT EXISTS service_requests (
      id          TEXT PRIMARY KEY,
      title       TEXT NOT NULL,
      description TEXT NOT NULL,
      profession  TEXT NOT NULL,
      location    TEXT NOT NULL,
      status      TEXT NOT NULL DEFAULT 'pending',
      urgency     TEXT NOT NULL DEFAULT 'regular',
      customer_id TEXT NOT NULL,
      accepted_by TEXT,
      created_at  TEXT NOT NULL,
      updated_at  TEXT NOT NULL,
      FOREIGN KEY (customer_id) REFERENCES users(id)
    )
  `);

  db.run(`
    CREATE TABLE IF NOT EXISTS professionals (
      id               TEXT PRIMARY KEY,
      user_id          TEXT NOT NULL UNIQUE,
      name             TEXT NOT NULL,
      email            TEXT NOT NULL,
      profession       TEXT NOT NULL,
      bio              TEXT,
      location         TEXT,
      experience_years INTEGER DEFAULT 0,
      service_rate     REAL    DEFAULT 0,
      education_level  TEXT,
      created_at       TEXT NOT NULL,
      updated_at       TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
  `);

  save();
}

function getDb() { return db; }

module.exports = { initDatabase, getDb, save };