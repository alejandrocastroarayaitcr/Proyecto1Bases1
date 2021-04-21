package com.xtream.api.Controller;

import com.xtream.api.Model.Carro;
import com.xtream.api.Repositories.CarrosRepo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CarroController {

    @GetMapping("/carro/{name}")
    public ResponseEntity<Carro> getCarroByName(@PathVariable String name){
        Carro carro = new Carro();
        carro.setNombre(name);
        return ResponseEntity.ok().body(new CarrosRepo(carro).execute());
    }
}
