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

ALTER TABLE `XtreamDB`.`transactionSubType` 
ADD COLUMN `xtreamPercentage` DECIMAL(5,2) NULL AFTER `name`;


CREATE TABLE `XtreamDB`.`userBalance` (
  `idUserBalance` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `checksum` VARCHAR(45) NULL,
  `lastUpdate` DATETIME NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idTransactionSubtype` INT NOT NULL,
  PRIMARY KEY (`idUserBalance`),
  INDEX `fk_userBalance_user1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_userBalance_transactionSubtype_idx` (`idTransactionSubtype` ASC) VISIBLE,
  CONSTRAINT `fk_userBalance_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userBalance_transactionSubtype`
    FOREIGN KEY (`idTransactionSubtype`)
    REFERENCES `XtreamDB`.`transactionSubType` (`idTransactionSubType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  