const express = require('express')
const app = express()
const port = 3000;
var top_categories_viewers = require('./routes/top_categories_viewers');
var top_lives_streams_for_category = require('./routes/top_lives_streams_for_category');
var donations_for_channel = require('./routes/donations_for_channel');
var all_donations_since = require('./routes/all_donations_since');

app.listen(port,() => {
    console.log(`Escuchando en htpp://localhost:${port}`)
});

app.use('/top_categories_viewers',top_categories_viewers)
app.use('/top_lives_streams_for_category',top_lives_streams_for_category)
app.use('/donations_for_channel',donations_for_channel)
app.use('/all_donations_since',all_donations_since)

const EventEmitter = require('events');
class MyEmitter extends EventEmitter {}
const myEmitter = new MyEmitter();
myEmitter.on('error', () => {
    console.error('Error: Los datos ingresados son invalidos.');
  });

app.get('*', function(req, res){
    myEmitter.emit('error');
    res.status(404).send('Error: Los datos ingresados son invalidos.');
    res.end();
});