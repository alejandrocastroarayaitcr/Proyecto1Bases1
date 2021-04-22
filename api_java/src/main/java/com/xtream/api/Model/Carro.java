package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;

@Getter
@Setter
@Entity
public class Carro {
    @Id
    String nombre;
    Date fechalanzamiento;
    String marca;
    String color;
    String material;
}