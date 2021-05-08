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
    set @tran=tran;

		if accepted=0 then
			set @status=3;
			update paymentAttempts
			SET idpaymentStatus=@status
			WHERE merchantTransactionNumber=@tran;
			
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
					
					select checksum into @checksum_1 from paymentAttempts WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
							
					set @ipAddress = concat(floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()));
							
					select computerName into @compName from paymentAttempts WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
							
					select description into @description from paymentAttempts WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
							
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
					SELECT postTime, checksum into @post_time, @checksum FROM paymentTransactions WHERE idPaymentTransactions=@last_id_in_paymentTransactions;
					insert into donationsPerUser(idUser, idDonations, idChannel, postTime, checksum)
					values (@user_id, @last_id_in_donations, @channel_id, @post_time, @checksum_1);
			end case;
		end if;
	END IF;
END$$
DELIMITER ;


