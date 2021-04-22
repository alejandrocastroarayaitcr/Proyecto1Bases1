package com.xtream.api.Controller;

import com.xtream.api.Model.Carro;
import com.xtream.api.Repositories.CarroRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CarroController {

    @GetMapping("/carro/{name}")
    public ResponseEntity<List<Carro>> getCarroByName(@PathVariable String name){
        Carro carro = new Carro();
        carro.setMaterial(name);
        return ResponseEntity.ok().body(new CarroRepository(carro).getCarroByName());
    }
}
