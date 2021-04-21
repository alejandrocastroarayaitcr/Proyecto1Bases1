package com.xtream.api.Repositories;

import com.xtream.api.HibernateUtil;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public abstract class SPInvoker<Model> {
    protected SessionFactory sessionFactory;

    private String procedureName;
    private String[] procedureParams;

    private Query spQuery;
    private String callStatement = "call %s (%s)";

    public SPInvoker(String procedureName, String[] procedureParams){
        this.procedureName = procedureName;
        this.procedureParams = procedureParams;

        spQuery = getFormattedSQL();

        sessionFactory = HibernateUtil.getSessionFactory();
    }

    // Execute the store procedure
    public abstract Model execute();

    // This will set the params for the SQL
    protected <Type> void setParam(String param, Type value){
        spQuery.setParameter(param, value);
    }

    // This will format the SQL with the SP name and its params
    private Query getFormattedSQL(){
        formatSPParams();

        String params = String.join(",", procedureParams);
        callStatement = String.format(callStatement, procedureName, params);

        return sessionFactory.openSession().createQuery(callStatement);
    }

    // This will format the params
    private void formatSPParams(){
        for (int i = 0; i < procedureParams.length; i++){
            procedureParams[i] = ":" + procedureParams[i];
        }
    }
}
