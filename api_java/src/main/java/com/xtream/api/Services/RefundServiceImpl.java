package com.xtream.api.Services;

import com.xtream.api.Model.ChangeStatus;
import com.xtream.api.Repositories.RefundRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Service
public class RefundServiceImpl implements RefundService{
    private final RefundRepository repository = RefundRepository.getInstance();

    @Override
    public void refund(ChangeStatus status) {
        repository.refund(status);
    }

    @Override
    public void changeStatus(ChangeStatus status) {
        repository.changeStatus(status);
    }
}
