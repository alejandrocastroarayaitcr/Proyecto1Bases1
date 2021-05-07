const express = require('express')
let app = express.Router()

app.get('/',function(req,res){
    const {StoredProcedure} = require('../generic-class');    
    const donationsForChannel = new StoredProcedure('donations_for_channel',[req.query.channelName]);
    donationsForChannel.executeSP = function(){
        this.sql = this.sql + "(?)";
        this.connection.query(this.sql, req.query.channelName, (error, results, fields) => {
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

module.exports = app