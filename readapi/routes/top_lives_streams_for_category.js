const express = require('express')
let app = express.Router()

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

module.exports = app;