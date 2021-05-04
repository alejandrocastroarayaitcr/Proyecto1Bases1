-- En esta transaccion se registra una transaccion realizada.
-- Se utiliza una flag para revisar si ya se ha iniciado una transaccion previamente, y esto se usa para determinar si se hace commit o rollback.

DROP PROCEDURE IF EXISTS registrar_transaccion;
DELIMITER $$

CREATE PROCEDURE registrar_transaccion(
    IN pSenderName varchar(45),
    IN pMerchant varchar(55),
	IN pAmount decimal(10,2),
    IN pCurrencySymbol VARCHAR(45),
	IN pDescription VARCHAR(55),
    IN pXTreamPercentage decimal(5,2),
    IN pComputerName VARCHAR(45),
    IN pIPAddress VARCHAR(45),
    IN pTransactionType VARCHAR(45),
    IN pTransactionSubType VARCHAR(45),
    IN transaccion_anterior bit
)
BEGIN

SET autocommit = 0;

SET @usuario = (SELECT idUser from users where users.username = pSenderName);

SET @inicie_transaccion = 0;
if @inicie_transaccion = 0 and transaccion_anterior = 0 then
	START TRANSACTION;
    SET @inicie_transaccion = 1;
end if;

INSERT INTO transactionType(name)
VALUES(pTransactionType);

SET @transaction_type = (SELECT idTransactionType from transactionType where transactionType.idTransactionType = last_insert_id());

INSERT INTO transactionSubType(name)
VALUES(pTransactionSubType);

SET @transaction_subtype = (SELECT IDTransactionSubType from transactionSubType where transactionSubType.idTransactionSubType = last_insert_id());

INSERT INTO paymentAttempts(postTime,amount,currencySymbol,referenceNumber,errorNumber,merchantTransactionNumber,description,paymentTimeStamp,computerName,ipAddress,checksum,idUser,idmerchants,idpaymentStatus)
VALUES(current_time(),pAmount,pCurrencySymbol,999999999999*RAND(),999999999999*RAND(),999999999999*RAND(),pDescription,current_time(),pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),@usuario,@merchant,@payment_status);

INSERT INTO paymentTransactions(postTime,description,username,computerName,ipAddress,checksum,amount,referenceID,idUser,idTransactionType,idTransactionSubType)
VALUES(current_time,pDescription,pSenderName,pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),pAmount,@transaction_subtype,@usuario,@transaction_type,@transaction_subtype);
SELECT last_insert_id() as transaccionNumber;

if @inicie_transaccion = 1 and transaccion_anterior = 0 then
	COMMIT;
end if;

END $$
DELIMITER ;

 CALL registrar_transaccion('ale123','PayPal',20.0,'$','this is a transaction',5.0,'AlePC','127.0.0.1','subscription','tier 4 subscription',0);
