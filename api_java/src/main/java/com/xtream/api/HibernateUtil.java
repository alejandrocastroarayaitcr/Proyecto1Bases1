package com.xtream.api;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static SessionFactory sessionFactory;

    static{
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    /**
     * This will allow the generic repo to get a session
     * @return a <code>SessionFactory</code>
     */
    // This will allow the generic repo to get a session
    public static SessionFactory getSessionFactory(){
        return sessionFactory;
    }

    /**
     * Closes caches and connections
     */
    public static void shutDown(){
        //
        getSessionFactory().close();
    }
}
