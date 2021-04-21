package com.xtream.api.Repositories;

import com.xtream.api.Model.Carro;

public class CarrosRepo extends SPInvoker<Carro> {

    public CarrosRepo(Carro carro) {
        super("view_carros_full_info", new String[]{carro.getNombre()});
    }

    @Override
    public Carro execute() {
        return new Carro();
    }
}
