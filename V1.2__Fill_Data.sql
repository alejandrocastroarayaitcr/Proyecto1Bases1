-- fill data procedure para llenar la base de datos con información
DROP PROCEDURE IF EXISTS filldata;

delimiter //

CREATE PROCEDURE filldata(IN opcion int, In cant int)
BEGIN
  declare opt int;
  DECLARE cantidad INT;
  DECLARE post_time DATETIME;
  DECLARE rate INT;
  DECLARE streamer_id bigint;
  DECLARE user_id bigint;
  DECLARE checksum_1 VARCHAR(45);
  DECLARE ipAddress VARCHAR(45);
  DECLARE channel_id bigint;
  set opt= opcion;
  set cantidad=cant;
	case opt
		-- Ratings
		when 1 then
        
			WHILE cantidad > 0 DO
            
				SET rate = RAND()*(5-1)+1;
				set ipAddress = concat(floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()));
				set checksum_1 = concat("checksum", floor(9999999*RAND()));
				
				select date_format(
				from_unixtime(
				 rand() * 
					(unix_timestamp(now()) - unix_timestamp('2018-11-13 23:00:00'))+unix_timestamp('2018-11-13 23:00:00')), '%Y-%m-%d %H:%i:%s') INTO post_time ; 
				
				set streamer_id=0;
				set user_id=0;
				while streamer_id=user_id do
					SELECT idUser INTO streamer_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
					SELECT idUser INTO user_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
				end while;
				
				INSERT INTO ratings (rating, postTime, idUser, idStreamer, checksum, ipAddress) 
				VALUES
				(rate, post_time, user_id, streamer_id, checksum_1, ipAddress);

				SET cantidad = cantidad - 1;
            
		  END WHILE;
	  
      -- Fill blacklist
	  when 2 then
		WHILE cantidad > 0 DO

            			
			select date_format(
			from_unixtime(
				 rand() * 
					(unix_timestamp(now()) - unix_timestamp('2018-11-13 23:00:00'))+unix_timestamp('2018-11-13 23:00:00')), '%Y-%m-%d %H:%i:%s') INTO post_time ; 
			set streamer_id=0;
            set user_id=0;
            while streamer_id=user_id do
				SELECT idUser INTO streamer_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
				SELECT idUser INTO user_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
			end while;
			
			INSERT INTO BlackList  
			VALUES (user_id, streamer_id, post_time);

			SET cantidad = cantidad - 1;
            
		END WHILE;
        
	-- Fill Streams
	when 3 then
		WHILE cantidad > 0 DO
        
			SELECT idChannel, live INTO channel_id, @Streamlive FROM Channel ORDER BY RAND()  LIMIT 1;

            select displayname into @name from Channel where channel_id=idChannel;
            
            SELECT idCategories INTO @categoria FROM categories ORDER BY RAND() LIMIT 1;
            
            select name into @cat from categories where @categoria=idCategories;
            
			set @title1 = concat("Stream de ", @cat);
            set @title2= concat(" By: ", @name);
            set @title= concat(@title1, @title2);
            
			select date_format(
			from_unixtime(
				 rand() * 
					(unix_timestamp(now()) - unix_timestamp('2018-11-13 23:00:00'))+unix_timestamp('2018-11-13 23:00:00')), '%Y-%m-%d %H:%i:%s') INTO post_time ;
		
			set @live= floor(rand()*2);
            
            if @live=1 and @Streamlive=0 then
				set @end_time= null;
                set @avrg_viewers=NULL ;
				set @max_viewers=NULL;
                set @viewers=rand()*10000;
                
                update Channel
                set live = 1 where idChannel = channel_id;
                
			else
				select date_format(
				from_unixtime(rand()* ((rand() *500000+unix_timestamp(post_time))-unix_timestamp(post_time))+unix_timestamp(post_time)), '%Y-%m-%d %H:%i:%s') INTO @end_time ;
                set @avrg_viewers=rand()*10000;
				set @max_viewers=@avrg_viewers+rand()*2000;
                set @viewers=NULL;
                set @live = 0;
                
            end if;
            
            
            select idPartnerProgram into @partner from Channel where channel_id=idChannel;
            
            IF  @partner is NULL then
				set @LimitDate=from_unixtime(unix_timestamp(@end_time)+1200000);
			else 
				set @LimitDate=from_unixtime(unix_timestamp(@end_time)+4800000);
            end if;
            
            
            if unix_timestamp(now())>unix_timestamp(@LimitDate) then
				set @deleted=1;
			else
				set @deleted=0;
            end if;
            
            insert into streams (`title`, `viewers`, `date`,`live`, `endedDate`, `averageViewers`, `maxiumViewers`, `deleted`, `storageLimitDate`, `idCategories`, `idChannel`)
            values(@title, @viewers, post_time, @live, @end_time, @avrg_viewers, @max_viewers,@deleted, @LimitDate, @categoria, channel_id);
            
            SET @last_id_in_streams = LAST_INSERT_ID();
            
             set @ntags= floor(rand()*3);
             while @ntags>0 do
                 SELECT idTags INTO @tag FROM tags ORDER BY RAND() LIMIT 1;
                 insert into TagsPerStream (`idTags`,`idStreams`)
                 values (@tag, @last_id_in_streams);
                 set @ntags= @ntags-1;
             end while;
            
             if @live=0 then
				 set @url= concat("htts:\WWW.URL",rand()*999999999);
				 set @size= rand()*10000;
				 set @length=unix_timestamp(@end_time)-unix_timestamp(post_time);
				 SELECT idvideoQuality INTO @quality FROM VideoQuality ORDER BY RAND() LIMIT 1;
				 SELECT idalloweddatatype INTO @type FROM AllowedDatatypes ORDER BY RAND() LIMIT 1;
				 insert into Videos (`url`,`size`,`length`,`deleted`,`videoQualityId`,`alloweddatatypeid`,`idStreams`)
				 values(@url, @size, @length, @deleted, @quality, @type, @last_id_in_streams);
             end if;
            
            SET cantidad = cantidad - 1;
            
	 END WHILE;
     
     -- Fill Stream History
	when 4 then
		WHILE cantidad > 0 DO
        
			SELECT idStreams INTO @stream_id FROM streams ORDER BY RAND() LIMIT 1;
            SELECT idChannel INTO @streamer_id FROM streams where idStreams=@stream_id;
            SELECT idUser INTO @user_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
            SELECT idStreamEventType INTO @EventType FROM StreamEventType ORDER BY RAND() LIMIT 1;
            
            while @streamer_id=@user_id do
				SELECT idUser INTO @user_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
			end while;
            
            SELECT date INTO @time1 FROM streams where idStreams=@stream_id;
            SELECT endedDate INTO @time2 FROM streams where idStreams=@stream_id;
            
            if @time2 is null then
            
				select date_format(
				from_unixtime(-200+
					 rand() * 
						(unix_timestamp(now()) - unix_timestamp(@time1))+unix_timestamp(@time1)), '%Y-%m-%d %H:%i:%s') INTO @start_Date;
						
				set @exit_Date = @start_Date;
                
				while @exit_Date<=@start_Date do
					select date_format(
					from_unixtime(
					 rand() * 
						(unix_timestamp(now()) - unix_timestamp(@time1))+unix_timestamp(@time1)), '%Y-%m-%d %H:%i:%s') INTO @exit_Date;
				end while;
                
            else 
				select date_format(
				from_unixtime(-200+
					 rand() * 
						(unix_timestamp(@time2) - unix_timestamp(@time1))+unix_timestamp(@time1)), '%Y-%m-%d %H:%i:%s') INTO @start_Date;
						
				set @exit_Date = @start_Date;
				
				while @exit_Date<=@start_Date do
					select date_format(
					from_unixtime(
					 rand() * 
						(unix_timestamp(@time2) - unix_timestamp(@time1))+unix_timestamp(@time1)), '%Y-%m-%d %H:%i:%s') INTO @exit_Date;
				end while;
			end if;
			
            insert into StreamLog (`PostTime`, `EndTime`, `idStreams`,`idUser`, `idStreamEventType`)
            values(@start_Date, @exit_Date, @stream_id, @user_id, @EventType);
			SET cantidad = cantidad - 1;
            
		END WHILE;
	-- Fill Donations
	when 5 then
		while cantidad >0 do
			
            SELECT idUser INTO @user_id FROM users where idUser<>1 ORDER BY RAND() LIMIT 1;
            
            set @amount_int= rand()*999;
            
			call paymentAttemp(1, @user_id, @amount_int);
            
            SET @last_id_in_paymentAttempts = LAST_INSERT_ID();
            
            select idpaymentStatus into @status from paymentAttempts WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
            
            SELECT idChannel into @channel_id FROM Channel ORDER BY RAND() LIMIT 1;
            select idUser into @streamer FROM Channel where idChannel=@channel_id; 
            
            if @status=1 then
            
				call paymentTran(1, @user_id, @amount_int, @streamer);
                
                SET @last_id_in_userBalance = LAST_INSERT_ID();
                
                select idPaymentTransactions into @last_id_in_paymentTransactions from userBalance where idUserBalance=LAST_INSERT_ID();
                
                select username into @username from users where idUser=@user_id;
                
                set @ipAddress = concat(floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()));
				
                select amount,computerName, description, checksum into @amount,@compName, @description, @checksum_1 from paymentAttempts WHERE idPaymentAttempts=@last_id_in_paymentAttempts;
				
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
				
                SELECT postTime, checksum into @post_time, @checksum FROM paymentTransactions WHERE idPaymentTransactions=@last_id_in_paymentTransactions;
                insert into donationsPerUser(idUser, idDonations, idChannel, postTime, checksum)
                values (@user_id, @last_id_in_donations, @channel_id, @post_time, @checksum_1);
                
				SET cantidad = cantidad - 1;
            end if;
		END WHILE;
	END CASE;
END //

delimiter ;

DROP PROCEDURE IF EXISTS paymentTran;

delimiter &&

CREATE PROCEDURE paymentTran(IN opt int, in userID BIGINT, in amount INT, in streamer bigint)
BEGIN

    select date_format(
		from_unixtime(
			rand() * (unix_timestamp(now()) - unix_timestamp('2018-11-13 23:00:00'))+unix_timestamp('2018-11-13 23:00:00')), '%Y-%m-%d %H:%i:%s') INTO @post_time ;
             
	set @user_id = userID;

	select username into @user from users where idUser=@user_id;
	set @title2= concat(" By: ", @user);
    
    set @compName2= concat("Desktop-",@user);
    set @compName = concat(@compName2, floor(999999*RAND()));
    
    set @amount_int= amount;
    SELECT CAST( @amount_int AS DECIMAL(10,2)) AS decimal_value into @amount;
    
    set @ipAddress = concat(floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()));
	set @checksum_1 = concat("checksum", 9999999*RAND() );
    
   case opt
  -- Donation
	when 1 then
		set @title1 = concat("Donation");
        set @description= concat(@title1, @title2);
        set @ttype=1;
		set @tsubtype=1;
  end case;
  
  insert into paymentTransactions(`postTime`,`description`,`computerName`, `ipAddress`,`checksum`,`amount`,`idStreamer`,`idUser`,`idTransactionType`,`idTransactionSubType`)
  values (@post_time, @description, @compName, @ipAddress, @checksum_1,@amount,streamer,@user_id,@ttype, @tsubtype);
  
  SET @last_id_in_paymentTransactions = LAST_INSERT_ID();
  
  select XtreamPercentage into @plataformPercentage from transactionSubType where idTransactionSubType=@tsubtype;
  set @userPercentage=100-@plataformPercentage;
  set @userAmount=(@userPercentage*@amount)/100;
  set @xtreamAmount=@amount-@userAmount;
  
  insert into userBalance (`amount`,`checksum`,`lastUpdate`,`percentageEarned`,`idUser`,`idPaymentTransactions`)
  values (@userAmount, @checksum_1,@post_time,@userPercentage,streamer,@last_id_in_paymentTransactions), (@xtreamAmount, @checksum_1,@post_time,@plataformPercentage,1,@last_id_in_paymentTransactions);
  
END &&

delimiter ;



DROP PROCEDURE IF EXISTS paymentAttemp;

delimiter &&

CREATE PROCEDURE paymentAttemp(IN opt int, userID BIGINT, amount INT)
BEGIN

    select date_format(
		from_unixtime(
			rand() * (unix_timestamp(now()) - unix_timestamp('2018-11-13 23:00:00'))+unix_timestamp('2018-11-13 23:00:00')), '%Y-%m-%d %H:%i:%s') INTO @post_time ;
            
	select date_format(
		from_unixtime(
			rand() * (unix_timestamp(now()) - @post_time)+@post_time), '%Y-%m-%d %H:%i:%s') INTO @stampTime ;
       
	set @user_id = userID;
    SELECT idMerchants INTO @merch FROM merchants ORDER BY RAND() LIMIT 1;
    SELECT idPaymentStatus INTO @status FROM paymentStatus where idPaymentStatus<>4 ORDER BY RAND() LIMIT 1;
    
    select username into @user from users where idUser=@user_id;
    
    set @compName2= concat("Desktop-",@user);
    set @compName = concat(@compName2, floor(999999*RAND()));

	select username into @user from users where idUser=@user_id;
	set @title2= concat(" By: ", @user);
    
    set @amount_int= amount;
    SELECT CAST( @amount_int AS DECIMAL(10,2)) AS decimal_value into @amount;
    
    set @merchNumber = ".";
	set @checksum_1 = concat("checksum", 9999999*RAND() );
    
    set @ipAddress = concat(floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()),".",floor(9999*RAND()));
    
   case opt
  -- Donation
	when 1 then
		set @title1 = concat("Donation");
        set @description= concat(@title1, @title2);
  end case;
  
  if @status=3 then
	set @error= floor(rand()*500);
  else
	set @error= Null;
  end if;
  
  insert into paymentAttempts(`postTime`,`amount`,`merchantTransactionNumber`, `description`,`paymentTimeStamp`,`computerName`, `ipAddress`,`checksum`,`idUser`,`idmerchants`,`currencySymbol`, `idpaymentStatus`, `errorNumber`)
  values (@post_time, @amount, @merchNumber, @description, @stampTime, @compName, @ipAddress, @checksum_1, @user_id, @merch,"$",@status, @error);
  
  SELECT name INTO @merchant from merchants where idMerchants=@merch;
  
  SET @last_id_in_idPayment = LAST_INSERT_ID();
  
  set @merchNumber= concat("PAYMENT-",@merchant,@last_id_in_idPayment);
  
  UPDATE paymentAttempts
  SET merchantTransactionNumber=@merchNumber
  WHERE idPaymentAttempts=@last_id_in_idPayment;
	
END &&

delimiter ;
call filldata(1,10);
call filldata(2,3);
call filldata(3,30);
call filldata(4,15);
call filldata(5,50);
