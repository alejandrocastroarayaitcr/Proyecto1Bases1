package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@Entity
public class TransactionSubType {
    @Id
    @Column
    private int idTransactionSubType;
    @Column
    private String name;
}
