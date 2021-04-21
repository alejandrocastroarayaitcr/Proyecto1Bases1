package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class Carro {
    String nombre;
    Date fechalanzamiento;
    String marca;
    String color;
    String material;
}
