const express = require('express')
const app = express()
const port = 3000;

app.listen(port,() => {
    console.log(`Listening at htpp://localhost:${port}`)
});

app.get('/foo', function (req, res) {
    res.json({"foo":"bar"});
});

app.use(express.urlencoded({
    extended: true
}));

app.post('/bar', function(req,res) {
    var body = req.body;
    console.log(req.body.foo);
    res.send(req.body.foo);
});

app.get('/donations_for_channel/:channelName',function(req,res){
    let mysql = require('mysql2');
let config = require('./config.js');

let connection = mysql.createConnection(config);

let sql = `CALL donations_for_channel(?)`;

connection.query(sql, req.params.channelName, (error, results, fields) => {
  if (error) {
    return console.error(error.message);
  }
  res.json(results[0]);
  console.log(results[0]);
});

connection.end();
});