package com.xtream.api.Repositories;

import com.xtream.api.Model.ChangeStatus;
import com.xtream.api.Model.PaymentAttempts;
import com.xtream.api.SPInvoker;

import java.util.List;

public class PaymentAttemptsRepository extends SPInvoker<PaymentAttempts> {
    private static PaymentAttemptsRepository repository;

    private String getPaymentAttempt = "SP_GET_PAYMENT_BY_TRAN_NUM(:tran)";

    private PaymentAttemptsRepository(){
        addProcedure(getPaymentAttempt, (query, changeStatus) -> {
            query.setParameter("tran", changeStatus.getMerchantTransactionNumber());
        });
    }

    public static PaymentAttemptsRepository getInstance(){
        if (repository == null){
            repository = new PaymentAttemptsRepository();
        }

        return repository;
    }

    public List<PaymentAttempts> getPaymentTransactionsByReference(ChangeStatus status){
        PaymentAttempts paymentAttempts = new PaymentAttempts();
        paymentAttempts.setMerchantTransactionNumber(status.getTran());

        return executeAndGetResults(getPaymentAttempt, paymentAttempts, PaymentAttempts.class);
    }
}
