package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Getter
@Setter
@Entity
public class PaymentAttempts {
    @Id
    private String merchantTransactionNumber;
    private Date postTime;
    private Double amount;
    private Integer referenceNumber;
    private String description;
    private Date paymentTimeStamp;
    private String currencySymbol;
}
