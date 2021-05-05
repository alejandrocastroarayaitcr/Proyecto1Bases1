const express = require('express')
let app = express.Router()

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

module.exports = app