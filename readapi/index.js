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