use XtreamDB;

SET SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS volume;

DELIMITER $$

CREATE PROCEDURE volume(
    IN inicio datetime,
    IN fin datetime 
)
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS temp_table(
		idRow int,
		month int,
        year year,
        amount decimal(10,2),
        intereactions bigint,
        category varchar(45)
	);
	
    set @n=1;
	set @month=MONTH(inicio), @year=YEAR(inicio);
    
    myloop: while (@year<=YEAR(fin)) DO
    
		IF @year=YEAR(FIN) and @month>MONTH(fin)THEN
			leave myloop;
        END IF;
        
		SELECT SUM(amount) INTO @cash FROM paymentTransactions
        WHERE MONTH(postTime) = @month AND YEAR(postTime) = @year;
		
		SELECT COUNT(*) into @pagos FROM paymentTransactions 
		WHERE MONTH(postTime) = @month AND YEAR(postTime) = @year;
		
		SELECT COUNT(*) into @interacciones FROM StreamLog
        WHERE MONTH(PostTime) = @month AND YEAR(PostTime) = @year;

		SELECT COUNT(*) into @streams FROM streams 
        WHERE MONTH(date) = @month AND YEAR(date) = @year;
		
		set @interaccionesT=@pagos+@streams+@interacciones;
        
        insert into temp_table
        values(@n,@month,@year,@cash,@interaccionesT,NULL);
        
        set @month=@month+1;
        if @month>12 then
			set @month=1,@year=@year+1;
        end if;
        
        set @n=@n+1;
        
	END WHILE;
    
    SELECT SUM(intereactions)/count(*), count(*) INTO @prom, @id FROM temp_table;
    set @high= (@prom*25)/100+@prom;
    set @low= @prom-(@high=(@prom*25)/100);
    
    while @id>0 DO
		
        SELECT intereactions INTO @val FROM temp_table
        where idRow=@id;
        
        if @val>=@high then
			set @cat= "High Volume";
		else
			if @val<=@low then
				set @cat= "Low Volume";
			else
				set @cat= "Medium Volume";
			end if;
        end if;
        
        UPDATE temp_table
        SET category=@cat
		where idRow=@id; 
        
        set @id=@id-1;
	
    END WHILE;
    
    select month as "Month", year as "Year", COALESCE(amount, 0 ) as "Handled Money", COALESCE(intereactions, 0 ) as "System Uses", category as "Category" from temp_table;
    DROP table temp_table;
END $$
DELIMITER ;

