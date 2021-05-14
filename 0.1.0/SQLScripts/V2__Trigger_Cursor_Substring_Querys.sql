-- trigger, cursor and substring

-- un trigger que utiliza un cursor y substring, se implementa para revisar antes de un insert a usuario para saber si el correo está disponible
use XtreamDB;

DELIMITER //
CREATE TRIGGER email_available BEFORE INSERT
ON users FOR EACH ROW
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE tmpEmail varchar(76);
	DECLARE readEmail CURSOR FOR SELECT email FROM users;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
    
    OPEN readEmail;
    
    read_loop : LOOP
		FETCH readEmail into tmpEmail;
        IF done THEN
			LEAVE read_loop;
		END IF;
        
        IF tmpEmail = new.email then
            SET @answer = CONCAT('The email beginning with ', substring_index(new.email, '@', 1), ' is already in use!'); -- acá se muestra el uso de substring
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @answer;
		END IF;

	END LOOP;

END//

DELIMITER ;

-- aca retorna el error
-- insert into users (idUser, firstname, lastname, username, email, verified, password, checksum)
 -- values(11,"Daniel", "Bejarano", "Beja420", "lolencioElCrack@gmail.com",1, 100010101001001110,"0x62736A696F");

-- aca se realiza bien
-- insert into users (idUser, firstname, lastname, username, email, verified, password, checksum)
-- values(11,"Daniel", "Bejarano", "Beja420", "dbejarano820@gmail.com",1, 100010101001001110,"0x62736A696F");
