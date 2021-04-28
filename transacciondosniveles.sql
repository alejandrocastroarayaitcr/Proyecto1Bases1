-- Esta stored procedure transaccional llama otra stored procedure transaccional que llama otra stored procedure transaccional (es de dos niveles).
-- Lo que sucede en esta stored procedure es que se registra una suscripcion por parte de un usuario hacia un canal. Para hacer esto debe registrar el pago y registrar la transaccion.
-- Si en algun momento falla se hace handling del error y se hace rollback. Si no falla, se hace commit.
-- Se utiliza una flag para revisar si ya se ha iniciado una transaccion previamente, y esto se usa para determinar si se hace commit o rollback.

DROP PROCEDURE IF EXISTS registrar_suscripcion;
DELIMITER $$

CREATE PROCEDURE registrar_suscripcion(
	IN pUsernameSender VARCHAR(70),
    IN pUsernameReceiver VARCHAR(45),
    IN pMerchantName VARCHAR(55),
    IN pTierName VARCHAR(45),
	IN pTitle VARCHAR(55),
    IN pDescriptionHTML VARCHAR(128),
    IN pDescription VARCHAR(45),
    IN pEndTime DATETIME,
    IN pIconURL varchar(45),
    IN pAmount decimal(10,2),
    IN pCurrencySymbol varchar(45),
    IN pXTreamPercentage decimal(5,2),
    IN pTransactionType varchar(45),
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
  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
  SELECT @full_error as mensaje_error;
 END;

SET autocommit = 0;

SET @usuarioSuscriptor = (SELECT idUser from users where users.username = pUsernameSender);
SELECT @usuarioSuscriptor as usuarioSuscriptor;

SET @usuarioReceptor = (SELECT idUser from users where users.username = pUsernameReceiver);
SELECT @usuarioReceptor as usuarioReceptor;

SET @tiername = (SELECT idTierLevel from tierLevel where tierLevel.name = pTierName);
SELECT @tiername as tiername;

SET @canal = (SELECT idChannel from Channel where Channel.idUser = @usuarioReceptor);
SELECT @canal as canal;

SET @inicie_transaccion = 0;
if @inicie_transaccion = 0 and transaccion_anterior = 0 then
	START TRANSACTION;
    SET @inicie_transaccion = 1;
end if;

CALL registrar_pago(pUsernameReceiver,pUsernameSender,pMerchantName,pAmount,pCurrencySymbol,pDescription,pXtreamPercentage,pComputerName,pIPAddress,pTransactionType,@inicie_transaccion,1);

INSERT INTO recurrenceType(name,valueToAdd,datePart)
VALUES(@canal,pAmount,DATE_FORMAT(now(),'%d-%m-%Y'));

SET @recurrence_id = last_insert_id();

INSERT INTO subscriptions(title,descriptionHTML,startTime,endTime,enabled,iconURL,checksum,amount,idRecurrenceType,idTierLevel)
VALUES(pTitle,pDescriptionHTML,current_time(),pEndTime,1,pIconURL,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),pAmount,recurrence_id,tiername);

SET @recent_subscriptionid = last_insert_id();

INSERT INTO subscriptionsPerUser(idUser,idSubscription,idChannel,postTime,nextTime,streak)
VALUES(@usuarioSuscriptor,@recent_subscriptionid,@canal,current_time(),pEndTime,0);

if @inicie_transaccion = 1 and transaccion_anterior = 0 then
	COMMIT;
end if;

END $$
DELIMITER ;

CALL registrar_suscripcion("alejandrocastro123","julioprofetv","PayPal","tier one","subscription","descriptionHTML","this is a transaction",current_time(),"imglink.com/123456.jpg",5.0,'$',20.0,"subscription","AlePC","127.0.0.1",0)
