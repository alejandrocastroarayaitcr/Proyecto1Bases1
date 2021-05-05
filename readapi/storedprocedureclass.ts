class StoredProcedure<Type> {
    nombre: Type;
    parameters: Type;

    constructor(nombre: Type , parameters: Type){
      this.nombre = nombre;
      this.parameters = parameters;
    }

    executeSP: (parameters: Type) => Type;
  }