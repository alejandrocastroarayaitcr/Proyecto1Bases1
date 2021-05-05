package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@Entity
public class Merchants {
    @Id
    @Column
    private int idMerchants;
    @Column
    private String name;
    @Column
    private String merchantUrl;
    @Column
    private String iconURL;
    @Column
    private boolean enabled;
}
