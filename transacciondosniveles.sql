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
    IN PTransactionType varchar(45),
    IN pComputerName varchar(45),
    IN pIPAddress varchar(45)
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

SET @usuarioSuscriptor = (SELECT idUser from users where users.username = pUsernameSender);
SELECT @usuarioSuscriptor as usuarioSuscriptor;

SET @usuarioReceptor = (SELECT idUser from users where users.username = pUsernameReceiver);
SELECT @usuarioReceptor as usuarioReceptor;

SET @tiername = (SELECT idTierLevel from tierLevel where tierLevel.name = pTierName);
SELECT @tiername as tiername;

SET @canal = (SELECT idChannel from Channel where Channel.idUser = @usuarioReceptor);
SELECT @canal as canal;

INSERT INTO recurrenceType(name,valueToAdd,datePart)
VALUES(@canal,pAmount,DATE_FORMAT(now(),'%d-%m-%Y'));

SET @recurrence_id = last_insert_id();

INSERT INTO subscriptions(title,descriptionHTML,startTime,endTime,enabled,iconURL,checksum,amount,idRecurrenceType,idTierLevel)
VALUES(pTitle,pDescriptionHTML,current_time(),pEndTime,1,pIconURL,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),pAmount,recurrence_id,tiername);

SET @recent_subscriptionid = last_insert_id();

INSERT INTO subscriptionsPerUser(idUser,idSubscription,idChannel,postTime,nextTime,streak)
VALUES(@usuarioSuscriptor,@recent_subscriptionid,@canal,current_time(),pEndTime,0);

END $$
DELIMITER ;

CALL registrar_suscripcion("alejandrocastro123","julioprofetv","PayPal","tier one","subscription","descriptionHTML","this is a transaction",current_time(),"imglink.com/123456.jpg",5.0,'$',20.0,"subscription","AlePC","127.0.0.1")
