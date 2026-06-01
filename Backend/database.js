const initSqlJs = require('sql.js');
const fs        = require('fs');
const path      = require('path');

const DB_PATH = path.join(__dirname, 'home_tweak.db');
let db;

async function initDatabase() {
  const SQL = await initSqlJs();
  db = fs.existsSync(DB_PATH)
    ? new SQL.Database(fs.readFileSync(DB_PATH))
    : new SQL.Database();
  createTables();
  console.log('✅ Database ready');
}

function save() {
  fs.writeFileSync(DB_PATH, Buffer.from(db.export()));
}

//SELECT, returns array of plain objects
function query(sql, params = []) {
  const stmt = db.prepare(sql);
  stmt.bind(params);
  const rows = [];
  while (stmt.step()) rows.push(stmt.getAsObject());
  stmt.free();
  return rows;
}

//insert/update/delete, auto-saves to file
function run(sql, params = []) {
  db.run(sql, params);
  save();
}

function ensureColumn(table, column, definition) {
  const columns = query(`PRAGMA table_info(${table})`).map((item) => item.name);
  if (!columns.includes(column)) {
    db.run(`ALTER TABLE ${table} ADD COLUMN ${definition}`);
    save();
  }
}

function createTables() {
  db.run(`
    CREATE TABLE IF NOT EXISTS users (
      id         TEXT PRIMARY KEY,
      name       TEXT NOT NULL,
      email      TEXT NOT NULL UNIQUE,
      password   TEXT NOT NULL,
      role       TEXT NOT NULL CHECK(role IN ('customer','professional')),
      location   TEXT NOT NULL DEFAULT '',
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
      customer_name TEXT NOT NULL DEFAULT '',
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

  ensureColumn('users', 'location', "location TEXT NOT NULL DEFAULT ''");
  ensureColumn('service_requests', 'customer_name', "customer_name TEXT NOT NULL DEFAULT ''");
  ensureColumn('users', 'photo_base64', 'photo_base64 TEXT');
  ensureColumn('professionals', 'skills', 'skills TEXT');
  ensureColumn('professionals', 'photo_base64', 'photo_base64 TEXT');
  ensureColumn('service_requests', 'photo_base64', 'photo_base64 TEXT');
  save();
}

module.exports = { initDatabase, query, run };