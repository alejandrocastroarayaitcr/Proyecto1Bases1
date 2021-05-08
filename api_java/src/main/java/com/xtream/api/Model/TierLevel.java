package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@Entity
public class TierLevel {
    @Id
    @Column
    private int idTierLevel;
    @Column
    private String name;
    @Column
    private String description;
    @Column
    private double price;
}
