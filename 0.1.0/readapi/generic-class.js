var StoredProcedure = /** @class */ (function () {
    function StoredProcedure(name, parameters) {
        this.name = name;
        this.parameters = parameters;
        this.mysql = require('mysql2');
        this.config = require('./config.js');
        this.connection = this.mysql.createConnection(this.config);
        this.sql = "CALL " + this.name;
    }
    StoredProcedure.prototype.executeSP = function () {
    };
    return StoredProcedure;
}());
module.exports.StoredProcedure = StoredProcedure;