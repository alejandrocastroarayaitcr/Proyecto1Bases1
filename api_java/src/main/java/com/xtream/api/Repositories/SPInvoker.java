package com.xtream.api.Repositories;

import org.springframework.beans.factory.annotation.Autowired;

public abstract class  SPInvoker<Model> {
    private String procedureName;
    private String[] procedureParams;

    private final String callStatement = "{call %s (%s)}";

    @Autowired
    public SPInvoker(String procedureName, String[] procedureParams){
        this.procedureName = procedureName;
        this.procedureParams = procedureParams;
    }

    // Execute the store procedure
    public abstract Model execute();

    // Joins the the sp name and params to the call statement into a string
    protected String getSPSQLSentence(){
        String params = String.join(", ", procedureParams);
        return String.format(callStatement, procedureName, params);
    }
}
