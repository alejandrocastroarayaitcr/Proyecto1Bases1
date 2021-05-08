package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SuscriptionsRegister {
    private User sender;
    private User receiver;
    private Merchants merchant;
    private TierLevel tier;
    private Suscriptions suscription;

    private String description;
    private String computerName;
    private String IP;
}
