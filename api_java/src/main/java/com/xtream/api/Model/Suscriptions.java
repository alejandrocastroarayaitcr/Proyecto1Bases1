package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity
public class Suscriptions {
    @Id
    private int idSubscriptions;
    @Column
    private String title;
    @Column
    private String descriptionHTML;
    @Column
    private Date startTime;
    @Column
    private Date endTime;
    @Column
    private boolean enabled;
    @Column
    private String iconURL;
    @Column
    private String checksum;
    @Column
    private double amount;
    @ManyToOne
    @JoinColumn(name="idPaymentTransactions")
    private PaymentTransactions paymentTransactions;
    @ManyToOne
    @JoinColumn(name="idTierLevel")
    private TierLevel tierLevel;
    @ManyToOne
    @JoinColumn(name="idRecurrenceType")
    private RecurrenceType recurrenceType;
}
