DROP PROCEDURE IF EXISTS registrar_pago;
DELIMITER $$

CREATE PROCEDURE registrar_transaccion(
	IN pReceiverName varchar(45),
    IN pSenderName varchar(45),
    IN pMerchant varchar(55),
	IN pAmount decimal(10,2),
    IN pCurrencySymbol VARCHAR(45),
	IN pDescription VARCHAR(55),
    IN pXTreamPercentage decimal(5,2),
    IN pComputerName VARCHAR(45),
    IN pIPAddress VARCHAR(45),
    IN pTransactionType VARCHAR(45)
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

SET @usuarioReceiver = (SELECT idUser from users where users.username = pReceiverName);
SELECT @usuarioReceiver as usuarioReceiver;

SET @usuarioSender = (SELECT idUser from users where users.username = pSenderName);
SELECT @usuarioSender as usuarioSender;

INSERT INTO transactionType(pTransactionType)
VALUES("subscription");

SET @transaction_type = (SELECT idTransactionType from transactionType where transactionType.idTransactionType = last_insert_id());
SELECT @transaction_type as transaction_type;

INSERT INTO paymentTransactions(postTime,description,receiverName,senderName,computerName,ipAddress,amount,checksum,xtreamPercentage,idUserReceiver,idUserSender,transactionType_idTransactionType)
VALUES(current_time,pDescription,pReceiverName,pSenderName,pComputerName,pIPAddress,pAmount,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),xtreamPercentage,@usuarioReceiver,@usuarioSender,@transaction_type);

INSERT INTO paymentAttempts(postTime,amount,currencySymbol,referenceNumber,errorNumber,merchantTransactionNumber,description,paymentTimeStamp,computerName,ipAddress,checksum,idUser,idmerchants,idpaymentStatus)
VALUES(current_time(),pAmount,pCurrencySymbol,pReferenceNumber,pErrorNumber,pMerchantTransactionNumber,pDescription,current_time(),pComputerName,pIPAddress,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),@usuario,@merchant,@payment_status);

END $$
DELIMITER ;

CALL registrar_transaccion("alejandrocastro123","julioprofetv","PayPal",20.0,"$","this is a transaction",5.0,"AlePC","127.0.0.1","subscription")