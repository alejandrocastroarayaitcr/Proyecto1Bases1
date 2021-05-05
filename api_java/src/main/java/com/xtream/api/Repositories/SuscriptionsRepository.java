package com.xtream.api.Repositories;

import com.xtream.api.Model.*;
import com.xtream.api.SPInvoker;

public class SuscriptionsRepository extends SPInvoker<SuscriptionsRegister> {
    public void SuscriptionsRepository(){
        addProcedure("registrar_suscripcion(:pUsernameSender, :pUsernameReceiver, :pMerchantName, :pTierName," +
                ":pTitle, :pDescriptionHTML, :pDescription, :pEndTime, :pIconURL, :pAmount, :pCurrencySymbol, :pXTreamPercentage," +
                ":pTransactionType, :pTransactionSubType, :pComputerName, :pIPAddress, :transaccion_anterior)", ((query, suscriptionsRegister) -> {
                    query.setParameter(":pUsernameSender", suscriptionsRegister.getSender().getUsername());
                    query.setParameter(":pUsernameReceiver", suscriptionsRegister.getReceiver().getUsername());
                    query.setParameter(":pMerchantName", suscriptionsRegister.getMerchant().getName());
                    query.setParameter(":pTierName", suscriptionsRegister.getTier().getName());
                    query.setParameter(":pTitle", suscriptionsRegister.getSuscription().getTitle());
                    query.setParameter(":pDescriptionHTML", suscriptionsRegister.getSuscription().getDescriptionHTML());
                    query.setParameter(":pDescription", suscriptionsRegister.getDescription());
                    query.setParameter(":pEndTime", "????");
                    query.setParameter(":pIconURL", suscriptionsRegister.getSuscription().getIconURL());
                    query.setParameter(":pAmount", suscriptionsRegister.getSuscription().getAmount());
                    query.setParameter(":pCurrencySymbol", "CRC???");
                    query.setParameter(":pXTreamPercentage", 20.0); // ???
                    query.setParameter(":pTransactionType", "????");
                    query.setParameter(":pTransactionSubType", "????");
                    query.setParameter(":pComputerName", suscriptionsRegister.getComputerName());
                    query.setParameter(":pIPAddress", suscriptionsRegister.getIP());
                    query.setParameter(":transaccion_anterior", "????");
        }));
    }

    public void registerSuscription(SuscriptionsRegister data){

    }
}
