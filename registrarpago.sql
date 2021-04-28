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
    IN pIPAddress VARCHAR(45)
)
BEGIN

DECLARE exit handler for SQLEXCEPTION
 BEGIN
  ROLLBACK;
  GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
   @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
  SELECT @full_error as mensaje_error;
 END;

SET @usuario = (SELECT idUser from users where users.username = pReceiverName);
SELECT @usuario as usuario;

SET @merchant = (SELECT idMerchants from merchants where merchants.name = pMerchant);
SELECT @merchant as merchant;

INSERT INTO paymentStatus(name)
VALUES("In progress");

SET @payment_status = (SELECT idPaymentStatus from paymentStatus where paymentStatus.idPaymentStatus = last_insert_id());
SELECT @payment_status as payment_status;

INSERT INTO paymentAttempts(postTime,amount,currencySymbol,referenceNumber,errorNumber,merchantTransactionNumber,description,paymentTimeStamp,computerName,ipAddress,checksum,idUser,idmerchants,idpaymentStatus)
VALUES(current_time(),pAmount,pCurrencySymbol,pReferenceNumber,pErrorNumber,pMerchantTransactionNumber,pDescription,current_time(),pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),@usuario,@merchant,@payment_status);

END $$
DELIMITER ;

CALL registrar_pago("alejandrocastro123","julioprofetv","PayPal",20.0,"$","this is a transaction",5.0,"AlePC","127.0.0.1")