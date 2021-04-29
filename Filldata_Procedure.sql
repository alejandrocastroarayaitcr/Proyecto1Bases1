DROP PROCEDURE IF EXISTS filldata

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
  DECLARE ipAddress BIGINT;
  DECLARE channel_id bigint;
  set opt= opcion;
  set cantidad=cant;
	case opt
		-- Ratings
		when 1 then
        
			WHILE cantidad > 0 DO
            
				SET rate = RAND()*(5-1)+1;
				set ipAddress = 999999999999*RAND();
				set checksum_1 = concat("checksum", 9999999*RAND() );
				
				select date_format(
				from_unixtime(
				 rand() * 
					(unix_timestamp(now()) - unix_timestamp('2018-11-13 23:00:00'))+unix_timestamp('2018-11-13 23:00:00')), '%Y-%m-%d %H:%i:%s') INTO post_time ; 
				
				set streamer_id=0;
				set user_id=0;
				while streamer_id=user_id do
					SELECT idUser INTO streamer_id FROM users ORDER BY RAND() LIMIT 1;
					SELECT idUser INTO user_id FROM users ORDER BY RAND() LIMIT 1;
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
				SELECT idUser INTO streamer_id FROM users ORDER BY RAND() LIMIT 1;
				SELECT idUser INTO user_id FROM users ORDER BY RAND() LIMIT 1;
			end while;
			
			INSERT INTO BlackList  
			VALUES (user_id, streamer_id, post_time);

			SET cantidad = cantidad - 1;
            
		END WHILE;
        
	-- Fill Streams
	when 3 then
		WHILE cantidad > 0 DO
        
			SELECT idChannel INTO channel_id FROM Channel ORDER BY RAND() LIMIT 1;

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
            
            if @live=1 then
				set @end_time= null;
                set @avrg_viewers=NULL ;
				set @max_viewers=NULL;
                set @viewers=rand()*10000;
			else
				select date_format(
				from_unixtime(rand()* ((rand() *500000+unix_timestamp(post_time))-unix_timestamp(post_time))+unix_timestamp(post_time)), '%Y-%m-%d %H:%i:%s') INTO @end_time ;
                set @avrg_viewers=rand()*10000;
				set @max_viewers=@avrg_viewers+rand()*2000;
                set @viewers=NULL;
                
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
                insert into TagsPerStream
                values (@tag, @last_id_in_streams);
                set @ntags= @ntags-1;
            end while;
            
            if @live=0 then
				set @url= concat("htts:\WWW.URL",rand()*999999999);
				set @size= rand()*10000;
				set @length=unix_timestamp(@end_time)-unix_timestamp(post_time);
				SELECT idvideoQuality INTO @quality FROM VideoQuality ORDER BY RAND() LIMIT 1;
				SELECT idalloweddatatype INTO @type FROM AllowedDatatypes ORDER BY RAND() LIMIT 1;
				insert into Videos (`url`,`size`,`length`,`videoQualityId`,`alloweddatatypeid`,`idStreams`)
				values(@url, @size, @length, @quality, @type, @last_id_in_streams);
            end if;
            
            SET cantidad = cantidad - 1;
            
	 END WHILE;
     
     -- Fill Stream History
	when 4 then
		WHILE cantidad > 0 DO
        
			SELECT idStreams INTO @stream_id FROM streams ORDER BY RAND() LIMIT 1;
            SELECT idChannel INTO @streamer_id FROM streams where idStreams=@stream_id;
            SELECT idUser INTO @user_id FROM users ORDER BY RAND() LIMIT 1;
            
            while @streamer_id=@user_id do
				SELECT idUser INTO @user_id FROM users ORDER BY RAND() LIMIT 1;
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
			
            insert into UserStreamHistory (`date`, `exitDate`, `idUser`,`idStreams`)
            values(@start_Date, @exit_Date, @user_id, @stream_id);
			SET cantidad = cantidad - 1;
            
		END WHILE;
	END CASE;
END //

delimiter ;

call filldata(1,10);
call filldata(2,3);
call filldata(3,25);
call filldata(4,15);




