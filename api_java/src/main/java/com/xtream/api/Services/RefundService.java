package com.xtream.api.Services;

import com.xtream.api.Model.ChangeStatus;
import org.springframework.http.HttpStatus;

public interface RefundService {
    void refund(ChangeStatus status);
    void changeStatus(ChangeStatus status);
}
