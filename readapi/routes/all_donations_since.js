const express = require('express')
let app = express.Router()

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

module.exports = app