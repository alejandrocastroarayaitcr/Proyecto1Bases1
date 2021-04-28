-- En esta stored procedure se registra un pago por parte de un usuario.
-- Se utiliza una flag para revisar si ya se ha iniciado una transaccion previamente, y esto se usa para determinar si se hace commit o rollback.

DROP PROCEDURE IF EXISTS registrar_pago;
DELIMITER $$

CREATE PROCEDURE registrar_pago(
	IN pReceiverName varchar(45),
    IN pSenderName varchar(45),
    IN pMerchant varchar(55),
	IN pAmount decimal(10,2),
    IN pCurrencySymbol VARCHAR(45),
	IN pDescription VARCHAR(55),
    IN pXTreamPercentage decimal(5,2),
    IN pComputerName VARCHAR(45),
    IN pIPAddress VARCHAR(45),
    IN pTransactionType VARCHAR(45),
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

SET @usuario = (SELECT idUser from users where users.username = pReceiverName);
SELECT @usuario as usuario;

SET @merchant = (SELECT idMerchants from merchants where merchants.name = pMerchant);
SELECT @merchant as merchant;

SET @inicie_transaccion = 0;
if @inicie_transaccion = 0 and transaccion_anterior = 0 then
	START TRANSACTION;
    SET @inicie_transaccion = 1;
end if;

INSERT INTO paymentStatus(name)
VALUES("In progress");

SET @payment_status = (SELECT idPaymentStatus from paymentStatus where paymentStatus.idPaymentStatus = last_insert_id());
SELECT @payment_status as payment_status;

INSERT INTO paymentAttempts(postTime,amount,currencySymbol,referenceNumber,errorNumber,merchantTransactionNumber,description,paymentTimeStamp,computerName,ipAddress,checksum,idUser,idmerchants,idpaymentStatus)
VALUES(current_time(),pAmount,pCurrencySymbol,pReferenceNumber,pErrorNumber,pMerchantTransactionNumber,pDescription,current_time(),pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),@usuario,@merchant,@payment_status);

CALL registrar_transaccion(pReceiverName,pSenderName,pMerchant,pAmount,pCurrencySymbol,pDescription,pXTreamPercentage,pComputerName,pIPAddress,pTransactionType,1);

if @inicie_transaccion = 1 and transaccion_anterior = 0 then
	COMMIT;
end if;

END $$
DELIMITER ;

CALL registrar_pago("alejandrocastro123","julioprofetv","PayPal",20.0,"$","this is a transaction",5.0,"AlePC","127.0.0.1","subscription",0)
