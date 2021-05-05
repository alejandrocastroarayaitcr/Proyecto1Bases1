let mysql = require('mysql2');
let config = require('./config.js');

let connection = mysql.createConnection(config);

let sql = `CALL donations_for_channel(?)`;

connection.query(sql, 'Florentino', (error, results, fields) => {
  if (error) {
    return console.error(error.message);
  }
  console.log(results[0]);
});

connection.end();