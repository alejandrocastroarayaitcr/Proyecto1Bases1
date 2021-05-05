"use strict";
exports.__esModule = true;
var StoredProcedure = /** @class */ (function () {
    function StoredProcedure(name, parameters) {
        this.name = name;
        this.parameters = parameters;
        this.mysql = require('mysql2');
        this.config = require('./config.js');
        this.connection = this.mysql.createConnection(this.config);
        this.sql = "CALL " + this.name + "(?)";
    }
    StoredProcedure.prototype.executeSP = function () {
    };
    return StoredProcedure;
}());
var DonationsForChannel = new StoredProcedure('donations_for_channel', ['Florentino']);
DonationsForChannel.executeSP = function () {
    this.connection.query(this.sql, 'Florentino', function (error, results, fields) {
        if (error) {
            return console.error(error.message);
        }
        console.log(results[0]);
    });
    this.connection.end();
};
DonationsForChannel.executeSP();
