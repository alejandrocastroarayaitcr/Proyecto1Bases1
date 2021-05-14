package com.xtream.api;


import org.hibernate.query.Query;

public interface SPData<Model>{

    /**
     * Execute the store procedure and returns a single object
     * @param query a native SQL hibernate query
     * @param model the entity object
     */
    public void setParams(Query query, Model model);
}
