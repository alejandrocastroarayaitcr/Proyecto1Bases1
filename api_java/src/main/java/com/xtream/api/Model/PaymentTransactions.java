package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity
public class PaymentTransactions {
    @Id
    @Column
    private int idPaymentTransactions;
    @Column
    private Date postTime;
    @Column
    private String description;
    @Column
    private String username;
    @Column
    private String computerName;
    @Column
    private String ipAddress;
    @Column
    private String checksum;
    @Column
    private double amount;
    @Column
    private int referenceID;
    @ManyToOne
    @JoinColumn(name="idUser")
    private User user;
    @ManyToOne
    @JoinColumn(name="idTransactionType")
    private TransactionType type;
    @ManyToOne
    @JoinColumn(name="idTransactionSubType")
    private TransactionSubType subType;
}
