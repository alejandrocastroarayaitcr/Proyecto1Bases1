package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@Entity
public class RecurrenceType {
    @Id
    @Column
    private int idRecurrenceType;
    @Column
    private String name;
    @Column
    private String valueToAdd;
    @Column
    private String datePart;
}
