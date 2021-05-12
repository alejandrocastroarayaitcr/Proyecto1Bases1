-- Esta stored procedure transaccional llama otra stored procedure transaccional que llama otra stored procedure transaccional (es de dos niveles).
-- Lo que sucede en esta stored procedure es que se registra una suscripcion por parte de un usuario hacia un canal. Para hacer esto debe registrar el pago y registrar la transaccion.
-- Si paymentTransactionsen algun momento falla se hace handling del error y se hace rollback. Si no falla, se hace commit.
-- Se utiliza una flag para revisar si ya se ha iniciado una transaccion previamente, y esto se usa para determinar si se hace commit o rollback.

DROP PROCEDURE IF EXISTS registrar_suscripcion;
DELIMITER $$

CREATE PROCEDURE registrar_suscripcion(
	IN pSubscriptionTypeName VARCHAR(76),
	IN pUsernameSender VARCHAR(70),
    IN pUsernameReceiver VARCHAR(45),
    IN pMerchantName VARCHAR(55),
    IN pTierName VARCHAR(45),
    IN pDescription VARCHAR(45),
    IN pEndTime DATETIME,
    IN pCurrencySymbol varchar(45),
    IN pXTreamPercentage decimal(5,2),
    IN pTransactionType varchar(45),
    IN pTransactionSubType varchar(45),
    IN pComputerName varchar(45),
    IN pIPAddress varchar(45),
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
  SET @full_error = ("ERROR al registrar la suscripcion. Se ha hecho rollback.");
  SELECT @full_error as mensaje_error;
 END;

SET autocommit = 0;

SET @usuarioSuscriptor = (SELECT idUser from users where users.username = pUsernameSender);

SET @usuarioReceptor = (SELECT idUser from users where users.username = pUsernameReceiver);

SET @tiername = (SELECT idTierLevel from tierLevel where tierLevel.name = pTierName);

SET @canal = (SELECT idChannel from Channel where Channel.idUser = @usuarioReceptor);

SET @inicie_transaccion = 0;
if @inicie_transaccion = 0 and transaccion_anterior = 0 then
	START TRANSACTION;
    SET @inicie_transaccion = 1;
end if;

CALL registrar_pago(pSubscriptionTypeName,pUsernameSender,pMerchantName,pCurrencySymbol,pDescription,pXtreamPercentage,pComputerName,pIPAddress,pTransactionType,pTransactionSubType,@inicie_transaccion);
SET @payment_transaction = last_insert_id();

SET @amount = (SELECT amount from subscriptionType where subscriptionType.name = pSubscriptionTypeName);

INSERT INTO recurrenceType(name,valueToAdd,datePart)
VALUES(@canal,@amount,DATE_FORMAT(now(),'%d-%m-%Y'));

SET @recurrence_id = last_insert_id();

set @subscriptionType_id = (SELECT idSubscriptionType from subscriptionType where subscriptionType.name = pSubscriptionTypeName);

INSERT INTO subscriptions(startTime,endTime,enabled,checksum,idRecurrenceType,idTierLevel,idPaymentTransactions,idSubscriptionType)
VALUES(current_time(),pEndTime,1,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),@recurrence_id,@tiername,@payment_transaction,@subscriptionType_id);

SET @recent_subscriptionid = last_insert_id();

INSERT INTO subscriptionsPerUser(idUser,idSubscriptions,idChannel,postTime,nextTime,streak)
VALUES(@usuarioSuscriptor,@recent_subscriptionid,@canal,current_time(),pEndTime,0);

if @inicie_transaccion = 1 and transaccion_anterior = 0 then
	COMMIT;
end if;

END $$
DELIMITER ;

CALL registrar_suscripcion('Tier one subscription','LolitoFNDZ','Yuen777','Walmart','Tier one','subscription by LolitoFNDZ',current_time(),'$',5.0,'subscription','tier one subscription','AlePC','127.0.0.1',0);