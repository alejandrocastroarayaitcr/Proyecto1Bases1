class StoredProcedure<Type>{
    name: String;
    parameters: Type[];
    mysql: any;
    config: any;
    connection: any;
    sql: String;

    constructor(name: String , parameters: Type[]){
      this.name = name;
      this.parameters = parameters;
      this.mysql = require('mysql2');
      this.config = require('./config.js');
      this.connection = this.mysql.createConnection(this.config);
      this.sql = `CALL ` + this.name;
    }

     executeSP(): void{
       
     }

  }