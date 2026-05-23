require('dotenv').config();
const express = require('express');
const cors    = require('cors');
const { initDatabase } = require('./database');

const app  = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use('/api/auth',          require('./routes/auth.routes'));
app.use('/api/requests',      require('./routes/requests.routes'));
app.use('/api/professionals', require('./routes/professionals.routes'));

app.get('/', (_, res) => res.json({ message: 'Home Tweak API running' }));

async function start() {
  await initDatabase();
  app.listen(PORT, () =>
    console.log(`🚀 Server on http://localhost:${PORT}`)
  );
}

start();