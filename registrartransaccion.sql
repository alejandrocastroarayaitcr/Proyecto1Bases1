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

 DECLARE exit handler for SQLEXCEPTION
 BEGIN
  if @inicie_transaccion = 1 and transaccion_anterior = 0 then
	ROLLBACK;
 end if;
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
@errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
 SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error as mensaje_error;
 END;

SET autocommit = 0;

SET @usuario = (SELECT idUser from users where users.username = pSenderName);
SELECT @usuario as usuario;

SET @inicie_transaccion = 0;
if @inicie_transaccion = 0 and transaccion_anterior = 0 then
	START TRANSACTION;
    SET @inicie_transaccion = 1;
end if;

INSERT INTO transactionType(name)
VALUES(pTransactionType);

SET @transaction_type = (SELECT idTransactionType from transactionType where transactionType.idTransactionType = last_insert_id());
SELECT @transaction_type as transaction_type;

INSERT INTO transactionSubType(name)
VALUES(pTransactionSubType);

SET @transaction_subtype = (SELECT IDTransactionSubType from transactionSubType where transactionSubType.idTransactionSubType = last_insert_id());
SELECT @transaction_subtype as transaction_subtype;

INSERT INTO paymentTransactions(postTime,description,username,computerName,ipAddress,checksum,amount,referenceID,idUser,idTransactionType,idTransactionSubType)
VALUES(current_time,pDescription,pSenderName,pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),pAmount,@transaction_subtype,@usuario,@transaction_type,@transaction_subtype);

INSERT INTO paymentAttempts(postTime,amount,currencySymbol,referenceNumber,errorNumber,merchantTransactionNumber,description,paymentTimeStamp,computerName,ipAddress,checksum,idUser,idmerchants,idpaymentStatus)
VALUES(current_time(),pAmount,pCurrencySymbol,999999999999*RAND(),999999999999*RAND(),999999999999*RAND(),pDescription,current_time(),pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),@usuario,@merchant,@payment_status);

if @inicie_transaccion = 1 and transaccion_anterior = 0 then
	COMMIT;
end if;

END $$
DELIMITER ;

CALL registrar_transaccion('julioprofetv','PayPal',20.0,'$','this is a transaction',5.0,'AlePC','127.0.0.1','subscription','tier 4 subscription',0)
