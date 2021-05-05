const express = require('express')
let app = express.Router()

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

module.exports = app