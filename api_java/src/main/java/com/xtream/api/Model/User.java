package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Getter
@Setter
@Entity
public class User {
    @Id
    @Column
    private int idUser;
    @Column
    private String firstname;
    @Column
    private String lastname;
    @Column
    private String username;
    @Column
    private String email;
    @Column
    private boolean verified;
    @Column
    private String password;
    @Column
    private String checksum;
}
