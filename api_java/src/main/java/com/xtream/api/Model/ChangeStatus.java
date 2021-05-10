package com.xtream.api.Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChangeStatus {
    private String tran;
    private int opt;
    private boolean accepted;

    public boolean isValidTransaction(){
        return getTran() != null && !getTran().isEmpty();
    }
}
