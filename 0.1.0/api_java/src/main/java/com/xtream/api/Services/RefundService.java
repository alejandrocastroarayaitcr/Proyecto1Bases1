package com.xtream.api.Services;

import com.xtream.api.Model.ChangeStatus;
import org.springframework.http.HttpStatus;

public interface RefundService {
    void refund(ChangeStatus status) throws Exception;
    void changeStatus(ChangeStatus status) throws Exception;
}
