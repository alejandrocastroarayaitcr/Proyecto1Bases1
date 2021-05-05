import { ConnectionOptions } from "tls";

class StoredProcedure <Type> {
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
      this.sql = `CALL ` + this.name + `(?)`;
    }

    executeSP():void{

    }

  }

  let DonationsForChannel = new StoredProcedure<String>('donations_for_channel',['Florentino']);
  DonationsForChannel.executeSP = function(){
    this.connection.query(this.sql, 'Florentino', (error: any, results: any, fields: any) => {
      if (error) {
        return console.error(error.message);
      }
      console.log(results[0]);
    });
  
    this.connection.end();
  };
  DonationsForChannel.executeSP();