const express = require('express')
const app = express()
const port = 3000;
var top_lives_streams_for_category = require('./routes/top_lives_streams_for_category.js');

app.listen(port,() => {
    console.log(`Listening at htpp://localhost:${port}`)
});

app.get('/top_lives_streams_for_category/:categoryName',function(req,res){
    const {StoredProcedure} = require('./generic-class');    
    const topLivesStreamsForCategory = new StoredProcedure('top_lives_streams_for_category',[req.params.categoryName]);
    topLivesStreamsForCategory.executeSP = function(){
        this.sql = this.sql + "(?)";
        this.connection.query(this.sql, this.parameters[0], (error, results, fields) => {
            if (error) {
              return console.error(error.message);
            }
            res.json(results[0]);
            console.log(results[0]);
          });
          
    }
    topLivesStreamsForCategory.executeSP();
    topLivesStreamsForCategory.connection.end();
});

app.get('/top_categories_viewers',function(req,res){
    const {StoredProcedure} = require('./generic-class');    
    const topCategoriesViewers = new StoredProcedure('top_categories_viewers',[]);
    topCategoriesViewers.executeSP = function(){
        this.connection.query(this.sql, (error, results, fields) => {
            if (error) {
              return console.error(error.message);
            }
            res.json(results[0]);
            console.log(results[0]);
          });
          
    }
    topCategoriesViewers.executeSP();
    topCategoriesViewers.connection.end();
});

app.get('/donations_for_channel/:channelName',function(req,res){
    const {StoredProcedure} = require('./generic-class');    
    const donationsForChannel = new StoredProcedure('donations_for_channel',[req.params.channelName]);
    donationsForChannel.executeSP = function(){
        this.sql = this.sql + "(?)";
        this.connection.query(this.sql, this.parameters[0], (error, results, fields) => {
            if (error) {
              return console.error(error.message);
            }
            res.json(results[0]);
            console.log(results[0]);
          });
          
    }
    donationsForChannel.executeSP();
    donationsForChannel.connection.end();
});

app.get('/all_donations_since/:sinceDATE',function(req,res){
    const {StoredProcedure} = require('./generic-class');    
    const allDonationsSince = new StoredProcedure('all_donations_since',[req.params.sinceDATE]);
    allDonationsSince.executeSP = function(){
        this.sql = this.sql + "(?)";
        this.connection.query(this.sql, this.parameters[0], (error, results, fields) => {
            if (error) {
              return console.error(error.message);
            }
            res.json(results[0]);
            console.log(results[0]);
          });
          
    }
    allDonationsSince.executeSP();
    allDonationsSince.connection.end();
});