-- Cambios a database

CREATE TABLE IF NOT EXISTS `XtreamDB`.`subscriptionType` (
  `idSubscriptionType` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(76) NOT NULL ,
  `descriptionHTML` VARCHAR(128) NOT NULL,
  `iconURL` VARCHAR(76) NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`idSubscriptionType`))
ENGINE = InnoDB;

ALTER TABLE `XtreamDB`.`subscriptions` 
DROP COLUMN `amount`,
DROP COLUMN `iconURL`,
DROP COLUMN `descriptionHTML`,
DROP COLUMN `title`,
CHANGE COLUMN `checksum` `checksum` VARBINARY(300) NULL,
ADD COLUMN `idSubscriptionType` INT NOT NULL AFTER `idPaymentTransactions`,
ADD INDEX `fk_subscriptions_subscriptionType1_idx` (`idSubscriptionType` ASC) VISIBLE,
ADD CONSTRAINT `fk_subscriptions_subscriptionType1`
  FOREIGN KEY (`idSubscriptionType`)
  REFERENCES `XtreamDB`.`subscriptionType` (`idSubscriptionType`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `XtreamDB`.`Videos` 
ADD COLUMN `deleted` BIT NOT NULL AFTER `length`;

ALTER TABLE `XtreamDB`.`Channel` 
ADD COLUMN `exclusiveVideos` BIT(1) NOT NULL AFTER `live`;

ALTER TABLE `XtreamDB`.`transactionSubType` 
ADD COLUMN `XtreamPercentage` DECIMAL(5,2) NULL AFTER `name`;

CREATE TABLE `XtreamDB`.`userBalance` (
  `idUserBalance` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `checksum` VARCHAR(45) NULL,
  `lastUpdate` DATETIME NOT NULL,
  `percentageEarned` DECIMAL(5,2) NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idPaymentTransactions` BIGINT NOT NULL,
  PRIMARY KEY (`idUserBalance`),
  INDEX `fk_userBalance_user1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_userBalance_paymentTransactions_idx` (`idPaymentTransactions` ASC) VISIBLE,
  CONSTRAINT `fk_userBalance_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userBalance_paymentTransactions`
    FOREIGN KEY (`idPaymentTransactions`)
    REFERENCES `XtreamDB`.`paymentTransactions` (`idPaymentTransactions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    -- Script de llenado
insert into users (idUser, firstname, lastname, username, email, verified, password, checksum)
values (1,"X", "-Tream", "X-Tream", "xtream@gmail.com",1, 100010101001001110,"0x62736A696F"),
(11,"Lolo", "Fernández", "LolitoFNDZ", "lolencioElCrack@gmail.com",1, 100010101001001110,"0x62736A696F"),
(2,"Taylor", "Hernández", "TAY-LORD_OF_THE_HELL", "taylor20sep.hc@gmail.com",0, 1101011001000,"0x669EB8A696F"),
(3,"Juan", "Vargas", "Fletes_Baratos", "juanVF@Yopmail.com",0, 100001011010111,"0x235FA4D89D3"),
(4,"Yuen", "Law", "Yuen777", "yuenlawTEC@Yopmail.com",1, 101110011010101,"0x3521BA7C459D"),
(5,"Alejandro", "Castro", "Don_Simon", "alejandro_gamer666@hotmail.com",0, 11101100000,"0x214CC7D958A"),
(6,"Ruben", "Viquez", "RubiusUwU", "rubiuNoSeasMalo@gmail.com",1, 1111110000001,"0x2A45D1D9581"),
(7,"Carlos", "Alvarado", "Charly_God", "ElPresi666@hotmail.com",0, 10000110001,"0x75ACB66BD20"),
(8,"Florentino", "Perez", "FlorentiNop", "florentinoPerez123@gmail.com",1, 101010111000,"0x123BDB66B01A"),
(9,"Francisco", "Franco", "xX_Franchesco_Xx", "arribaFranco@gmail.com",1, 1001011000101,"0x41C2ABF45E"),
(10,"Luis", "Miguel", "eLSolazo", "luismiguelelcrack@hotmail.com",0, 1110010110100,"0x541AB2CCF12");

insert into Channel ( `idChannel`,`displayName` ,`description` ,`pictureURL`,`live`,`exclusiveVideos`,`idUser`)
values(11,"Lolito", "Jejeje yepas jeje", "https://images.app.goo.gl/cpDD8XVikgPnEnJd9",0, 0, 11),
(2,"Tay-Lord", "momento xd", "https://images.app.goo.gl/HNA2H1Vz1GDaoCrv9",0, 0,2),
(3,"Juancin", "Mi madre me dio la vida, pero Tusa las ganas de vivirla", "https://images.app.goo.gl/agBxQAekVfxux95A7",0, 0,3),
(4,"Yuen", "Lo unico más duro en esta vida que un algoritmo NP-Duro, es no tenerte baby", "https://images.app.goo.gl/ufMstNaYFzmno8GM6",0, 0,4),
(5,"Ale-Luya", "Simón", "https://images.app.goo.gl/iqNTDrC7zEkiZgn77",0, 0,5),
(6,"Rubiu", "ust ust", "https://images.app.goo.gl/EibfqZS5EPee3zJ3A",0, 0,6),
(7,"Charly Alvarado", "Un chuzo de mae", "https://images.app.goo.gl/VWkNwDSPrUwpDUrf7",0,0, 7),
(8,"Florentino", "Ni tan superman va a ser tan Super como mi liga. HALA MADRID!. SIUUUU", "https://images.app.goo.gl/gMuiRSMGrp7f9coe6", 0,0,8),
(9,"Franco", "Arriba España. Si España te ataca, no hay error, no hay error", "https://images.app.goo.gl/Di6caAhjUKbw8BKx7",0, 0,9),
(10,"LuisMi", "Si tú me hubieras dicho siempre la verdad, Si hubieras respondido cuando te llamé, Si hubieras amado cuando te amé, Serías en mis sueños la mejor mujer… ", "https://images.app.goo.gl/PudHayh5p9ZofEAfA",0, 0,10);

insert into categories (`name`)
values ("Legue Of Legends"), ("The Binding Of Isaac"), ("Warzone"), ("Genshi Impact"), ("Just Talking"), ("ASMR"), ("Free Fire"), ("Clash Royale"), ("Mongos"), 
("Betrayel.io"), ("Valorant"),("Fortnie"),("Agar.io"),("Pinturillo"), ("Omegle"), ("Blog en Vivo"), ("Programación");

insert into tags (`name`)
values ("RPG"), ("Shooter"), ("Random"), ("Blog"), ("Funny"), ("Girl"), ("Mobile"), ("Acción"), ("MOBA"), 
("IRL"), ("Carreras"),("Plataformas"),("Terror"),("Simulación"), ("Puzle");

insert into VideoQuality(`quality`)
values  ("144"), ("240"), ("360"), ("480"),("720"),("1080");

insert into AllowedDatatypes(`datatype`)
values  ("MP3"), ("MP4"), ("MPEG-4"), ("MOV");

insert into StreamEventType(`name`)
values ("Enter"),("Leave"),("Donate");

insert into transactionType(`name`)
values ("P2P"),("Cancelation"),("Register");

insert into transactionSubType(`name`,`XtreamPercentage`)
values ("Donation",0), ("Subscription",20.2);

insert into paymentStatus(name)
values("Accepted"),("In process"),("Declined");

insert into merchants(name,merchantURL,iconURL,enabled)
values ("McDonalds", "https://www.mcdonalds.co.cr/", "https://images.app.goo.gl/sAYT9hFoUUZT95Yb8", 1),
("Logitech", "https://www.logitechg.com/es-roam", "https://images.app.goo.gl/GYBj1xURa1KFocfC9", 1),
("Playstation", "https://www.playstation.com/es-cr/", "https://images.app.goo.gl/xnNZBeUWHr9QV4AU9", 1),
("Pollolandia", "https://pollolandia.com/cr/index.php/component/users/?view=remind", "https://images.app.goo.gl/KrWHY9WT4ZimErhx9", 0),
("Walmart", "https://walmart.co.cr/", "https://images.app.goo.gl/ruF2CG4vxZHjtY1E6", 0);




  