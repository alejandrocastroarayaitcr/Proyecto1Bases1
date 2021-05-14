package com.xtream.api.Services;

import com.xtream.api.Model.ChangeStatus;
import com.xtream.api.Model.PaymentAttempts;
import com.xtream.api.Repositories.PaymentAttemptsRepository;
import com.xtream.api.Repositories.RefundRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RefundServiceImpl implements RefundService{
    private final RefundRepository repository = RefundRepository.getInstance();
    private final PaymentAttemptsRepository paymentAttemptsRepository = PaymentAttemptsRepository.getInstance();

    @Override
    public void refund(ChangeStatus status) throws Exception {
        List<PaymentAttempts> paymentAttemptsList = paymentAttemptsRepository.getPaymentTransactionsByReference(status);

        if (paymentAttemptsList.size() == 0){
            throw new Exception("Payment Attempt doesnt exists");
        }

        repository.refund(status);
    }

    @Override
    public void changeStatus(ChangeStatus status) throws Exception  {
        List<PaymentAttempts> paymentAttemptsList = paymentAttemptsRepository.getPaymentTransactionsByReference(status);

        if (paymentAttemptsList.size() == 0){
            throw new Exception("Payment Attempt doesnt exists");
        }

        repository.changeStatus(status);
    }
}
