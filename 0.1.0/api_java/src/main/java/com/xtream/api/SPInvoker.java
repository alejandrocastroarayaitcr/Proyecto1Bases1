package com.xtream.api;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

public abstract class SPInvoker<Model> {
    protected SessionFactory sessionFactory;

    private HashMap<String, SPData<Model>> procedures;
    private String callStatement;

    /**
     * Constructor
     */
    public SPInvoker(){
        sessionFactory = HibernateUtil.getSessionFactory();
        callStatement = "call %s";
        procedures = new HashMap<>();
    }

    /**
     * Execute the store procedure and returns a list of objects
     * @param procedure the name of the sp, model
     * @param model the entity object
     * @param type the class type of model
     * @return a <code>List<Model></code> a generic type with the fetch result
     */
    @SuppressWarnings("unchecked")
    protected List<Model> executeAndGetResults(String procedure, Model model, Class<Model> type){
        Session session = sessionFactory.openSession();

        Query query = session.createSQLQuery(getSPSQL(procedure)).addEntity(type);

        procedures.get(procedure).setParams(query, model);

        List<Model> rst = (List<Model>) query.list();

        session.close();

        return rst;
    }

    /**
     * Execute the store procedure and returns a single object
     * @param procedure the name of the sp, model
     * @param model the entity object
     * @param type the class type of model
     * @return a <code>Model</code> a generic type with the fetch result
     */
    protected Model executeAndGetResult(String procedure, Model model, Class<Model> type){
        Session session = sessionFactory.openSession();

        Query query = session.createSQLQuery(getSPSQL(procedure)).addEntity(type);

        procedures.get(procedure).setParams(query, model);

        Model rst = (Model) query.list().get(0);

        session.close();

        return rst;
    }

    /**
     * This will execute a procedure
     * @param procedure the name of the sp, model
     * @param model the entity object
     */
    protected void execute(String procedure, Model model){
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        Query query = session.createSQLQuery(getSPSQL(procedure));

        procedures.get(procedure).setParams(query, model);

        query.executeUpdate();
        session.getTransaction().commit();
        session.close();
    }

    /**
     * This will allow you to add a new procedure to the invoker
     * @param procedure the name of the sp, model
     * @param setParams a lambda function with the method to set the parameters through a Query object
     */
    protected void addProcedure(String procedure, SPData<Model> setParams){
        procedures.put(procedure, setParams);
    }

    /**
     * This will remove a procedure from the invoker
     * @param procedure the name of the sp, model
     * @return a <code>SPData<Model></code> a interface with the method to set the params
     */
    protected SPData<Model> removeProcedure(String procedure){
        return procedures.remove(procedure);
    }

    /**
     * This will format the SQL with the SP name and its params
     * @param procedureName the name of the sp, model
     * @return a <code>String</code> with the SQL statement for a SP Call
     */
    private String getSPSQL(String procedureName){
        return String.format(callStatement, procedureName);
    }
}
