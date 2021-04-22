package com.xtream.api.Repositories;

import com.xtream.api.HibernateUtil;
import com.xtream.api.Model.Carro;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public abstract class SPInvoker<Model> {
    protected SessionFactory sessionFactory;

    private String procedureName;
    private String[] procedureParams;

    private String callStatement;

    public SPInvoker(String procedureName, String[] procedureParams){
        this.procedureName = procedureName;
        this.procedureParams = procedureParams;

        sessionFactory = HibernateUtil.getSessionFactory();

        callStatement = "call %s (%s)";
    }

    // Execute the store procedure and returns a single object
    protected List<Model> executeAndGetResults(){
        Session session = getSessionFactory().openSession();
        //Transaction tx = session.beginTransaction();

        Query query = session.createSQLQuery(getFormattedSQL()).addEntity(getClassType());

        setParams(query);

        List<Model> rst = (List<Model>) query.list();

        session.close();

        return rst;
    }

    // Execute the store procedure and returns a single object
    protected Model executeAndGetResult(){
        Session session = getSessionFactory().openSession();
        //Transaction tx = session.beginTransaction();

        Query query = session.createSQLQuery(getFormattedSQL()).addEntity(getClassType());

        setParams(query);

        Model rst = (Model) query.getSingleResult();

        session.close();

        return rst;
    }

    protected void execute(){
        Session session = getSessionFactory().openSession();
        //Transaction tx = session.beginTransaction();

        Query query = session.createSQLQuery(getFormattedSQL()).addEntity(getClassType());

        setParams(query);

        session.close();
    }

    protected abstract void setParams(Query query);

    protected abstract Class<Model> getClassType();

    // This will format the SQL with the SP name and its params
    protected String getFormattedSQL(){
        String params = String.join(",", formatSPParams());
        return String.format(callStatement, procedureName, params);
    }

    // This will format the params
    private String[] formatSPParams(){
        String[] copy = procedureParams.clone();

        for (int i = 0; i < copy.length; i++){
            copy[i] = ":" + copy[i];
        }

        return copy;
    }

    // Getter for session factory
    protected SessionFactory getSessionFactory() {return sessionFactory;}
}
