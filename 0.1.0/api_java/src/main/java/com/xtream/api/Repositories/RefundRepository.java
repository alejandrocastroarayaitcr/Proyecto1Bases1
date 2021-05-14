package com.xtream.api.Repositories;

import com.xtream.api.Model.ChangeStatus;
import com.xtream.api.SPInvoker;

public class RefundRepository extends SPInvoker<ChangeStatus> {
    private static RefundRepository repository;

    private String refundSP = "refunds(:tran)";
    private String changeStatusSP = "change_status(:tran, :accepted, :opt)";

    private RefundRepository(){
        addProcedure(refundSP, (query, changeStatus) -> {
            query.setParameter("tran", changeStatus.getTran());
        });

        addProcedure(changeStatusSP, (query, changeStatus) -> {
            query.setParameter("tran", changeStatus.getTran());
            query.setParameter("accepted", changeStatus.isAccepted());
            query.setParameter("opt", changeStatus.getOpt());
        });
    }

    public static RefundRepository getInstance(){
        if (repository == null){
            repository = new RefundRepository();
        }

        return repository;
    }

    public void changeStatus(ChangeStatus status){
        execute(changeStatusSP, status);
    }

    public void refund(ChangeStatus status){
        execute(refundSP, status);
    }
}
