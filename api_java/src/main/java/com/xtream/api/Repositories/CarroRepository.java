package com.xtream.api.Repositories;

import com.xtream.api.Model.Carro;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CarroRepository extends SPInvoker<Carro> {
    private Carro carro;

    public CarroRepository(Carro carro){
        super("sp_carros_find_material", new String[]{"nombre"});
        this.carro = carro;
    }

    public List<Carro> getCarroByName(){
        return executeAndGetResults();
    }

    @Override
    protected void setParams(Query query) {
        query.setParameter("nombre", carro.getMaterial());
    }

    @Override
    protected Class<Carro> getClassType() {
        return Carro.class;
    }
}
