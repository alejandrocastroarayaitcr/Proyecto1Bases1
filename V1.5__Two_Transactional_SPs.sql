-- Dos Stored procedures transaccionales transaccionales, útiles para el sistema que haga escritura en al menos 3 tablas

-- Modificación de estado de pagó de donación
USE `XtreamDB` ;
SET SQL_SAFE_UPDATES = 0;
DROP PROCEDURE IF EXISTS change_status;

DELIMITER $$

CREATE PROCEDURE change_status(
    IN tran varchar(45),
    in accepted bit,
    in opt int
)
BEGIN
	
    select idpaymentStatus into @status from paymentAttempts where merchantTransactionNumber=tran;
    if @status=2 then

		if accepted=0 then
			set @status=3;
			update paymentAttempts
			SET idpaymentStatus=@status
			WHERE merchantTransactionNumber=tran;
			
		else
			set @status=1;
            
			update paymentAttempts
			SET idpaymentStatus=@status
			WHERE merchantTransactionNumber=tran;
			
			SELECT idPaymentAttempts,idUser,amount INTO @last_id_in_paymentAttempts,@user_id, @amount FROM paymentAttempts WHERE merchantTransactionNumber=tran;
			
			call paymentTran(1, @user_id, @amount);
			
			SET @last_id_in_userBalance = LAST_INSERT_ID();
							
			select idPaymentTransactions into @last_id_in_paymentTransactions from userBalance where idUserBalance=LAST_INSERT_ID();
				
			case opt
			
			when 1 then
					
					select username into @username from users where idUser=@user_id;
						
					select computerName, description, checksum, ipAddress  into @compName, @description, @checksum_1, @ipAddress from paymentAttempts 
                    WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
							
					set @message= concat("Hola bro, salu2 te desea ", @username);
					insert into donations (amount,message,checksum, idPaymentTransactions)
					values (@amount,@message,@checksum_1, @last_id_in_paymentTransactions);
							
					SET @last_id_in_donations = LAST_INSERT_ID();
							
					UPDATE paymentAttempts
					SET referenceNumber=@last_id_in_donations, ipAddress=@ipAddress
					WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
							
					UPDATE paymentTransactions
					SET referenceID=@last_id_in_donations, amount=@amount,checksum=@checksum_1, ipAddress=@ipAddress,computerName=@compName,description=@description, idUser=@user_id
					WHERE idPaymentTransactions=@last_id_in_paymentTransactions;
					
					SELECT idChannel into @channel_id FROM Channel ORDER BY RAND() LIMIT 1;
					SELECT postTime into @post_time FROM paymentTransactions WHERE idPaymentTransactions=@last_id_in_paymentTransactions;
					insert into donationsPerUser(idUser, idDonations, idChannel, postTime, checksum)
					values (@user_id, @last_id_in_donations, @channel_id, @post_time, @checksum_1);
                    
			end case;
		end if;
	END IF;
END$$
DELIMITER ;

-- Rembolsos
DROP PROCEDURE IF EXISTS refunds;

DELIMITER %%

CREATE PROCEDURE refunds(
    IN tran varchar(45)
)
BEGIN
	
    select idpaymentStatus into @status from paymentAttempts where merchantTransactionNumber=tran;
    if @status=1 then
    
			set @status=4;
			update paymentAttempts
			SET idpaymentStatus=@status
			WHERE merchantTransactionNumber=tran;
			
			SELECT referenceNumber INTO @reference FROM paymentAttempts WHERE merchantTransactionNumber=tran;
            
			update paymentTransactions
			SET amount=0, description="REFUNDED"
			WHERE referenceID=@reference;
			
			SELECT idPaymentTransactions,idTransactionSubType INTO @idPayment,@stype from paymentTransactions WHERE referenceID=@reference;
							
			update userBalance
			SET amount=0, lastUpdate=now(), percentageEarned=0
			WHERE idPaymentTransactions=@idPayment;
				
			case @stype
			
			when 1 then
            
				update donations
				SET amount=0
				WHERE idDonations=@reference;
                
			end case;
	end if;
END%%
DELIMITER ;



