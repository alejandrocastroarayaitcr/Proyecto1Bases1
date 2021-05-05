package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@Entity
public class TransactionType {
    @Id
    @Column
    private int idTransactionType;
    @Column
    private String name;
}
