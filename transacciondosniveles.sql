ALTER TABLE subscriptions MODIFY idSubscriptions int NOT NULL AUTO_INCREMENT;

DROP PROCEDURE IF EXISTS registrar_suscripcion;
DELIMITER $$

CREATE PROCEDURE registrar_suscripcion(
	IN pUsername VARCHAR(70),
    IN pTierName VARCHAR(45),
	IN pTitle VARCHAR(55),
    IN pDescriptionHTML VARCHAR(128),
    IN pEndTime DATETIME,
    IN pIconURL varchar(45),
    IN pAmount decimal(10,2),
    IN pCurrencySymbol char
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

SET @usuario = (SELECT idUser from users where users.username = pUsername);
SELECT @usuario as usuario;

SET @tiername = (SELECT idTierLevel from tierLevel where tierLevel.name = pTierName);
SELECT @tiername as tiername;

SET @canal = (SELECT idChannel from Channel where Channel.idUser = @usuario);
SELECT @canal as canal;

INSERT INTO subscriptions(title,descriptionHTML,startTime,endTime,enabled,iconURL,checksum,amount)
VALUES(pTitle,pDescriptionHTML,current_time(),pEndTime,1,pIconURL,sha1(concat(@usuario,current_time(),char(round(rand()*25)+97))),pAmount);

SET @recent_subscriptionid = last_insert_id();

INSERT INTO subscriptionsPerUser(idUser,idSubscription,idChannel,postTime,nextTime,streak)
VALUES(@usuario,@recent_subscriptionid,@canal,current_time(),pEndTime,0);

END $$
DELIMITER ;

CALL registrar_suscripcion("alejandrocastro123","tier one","subscription","description",current_time(),"imglink.com/123456.jpg",5.0,'$')