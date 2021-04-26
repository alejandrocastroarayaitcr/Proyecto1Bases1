-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyecto1_BD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto1_BD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto1_BD` DEFAULT CHARACTER SET utf8 ;
USE `proyecto1_BD` ;

-- -----------------------------------------------------
-- Table `proyecto1_BD`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`users` (
  `idUser` BIGINT NOT NULL,
  `firstname` VARCHAR(70) NOT NULL,
  `lastname` VARCHAR(70) NOT NULL,
  `username` VARCHAR(70) NOT NULL,
  `email` VARCHAR(76) NOT NULL,
  `verified` BIT NOT NULL,
  `password` BINARY(255) NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`merchants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`merchants` (
  `idMerchants` INT NOT NULL,
  `name` VARCHAR(55) NOT NULL,
  `merchantURL` VARCHAR(76) NOT NULL,
  `iconURL` VARCHAR(76) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`idMerchants`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`paymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`paymentStatus` (
  `idPaymentStatus` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPaymentStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`paymentAttempts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`paymentAttempts` (
  `idPaymentAttempts` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `currencySymbol` VARCHAR(45) NOT NULL,
  `referenceNumber` BIGINT NOT NULL,
  `errorNumber` BIGINT NULL,
  `merchantTransactionNumber` BIGINT NOT NULL,
  `description` NVARCHAR(8000) NOT NULL,
  `paymentTimeStamp` DATETIME NOT NULL,
  `computerName` VARCHAR(55) NOT NULL,
  `ipAddress` BIGINT NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idmerchants` INT NOT NULL,
  `idpaymentStatus` INT NOT NULL,
  PRIMARY KEY (`idPaymentAttempts`),
  INDEX `fk_paymentAttempts_users_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_paymentAttempts_merchants1_idx` (`idmerchants` ASC) VISIBLE,
  INDEX `fk_paymentAttempts_paymentStatus1_idx` (`idpaymentStatus` ASC) VISIBLE,
  CONSTRAINT `fk_paymentAttempts_users`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentAttempts_merchants1`
    FOREIGN KEY (`idmerchants`)
    REFERENCES `proyecto1_BD`.`merchants` (`idMerchants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentAttempts_paymentStatus1`
    FOREIGN KEY (`idpaymentStatus`)
    REFERENCES `proyecto1_BD`.`paymentStatus` (`idPaymentStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`recurrenceType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`recurrenceType` (
  `idRecurrenceType` INT NOT NULL,
  `name` VARCHAR(55) NOT NULL,
  `valueToAdd` VARCHAR(45) NOT NULL,
  `datePart` VARCHAR(45) NULL,
  PRIMARY KEY (`idRecurrenceType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`tierLevel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`tierLevel` (
  `idTierLevel` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(75) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idTierLevel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`subscriptions` (
  `idSubscriptions` INT NOT NULL,
  `title` VARCHAR(55) NOT NULL,
  `descriptionHTML` VARCHAR(128) NOT NULL,
  `startTime` DATETIME NOT NULL,
  `endTIme` DATETIME NOT NULL,
  `enabled` BIT NOT NULL,
  `iconURL` VARCHAR(76) NOT NULL,
  `xtreamRevenue` DECIMAL(10,2) NOT NULL,
  `idRecurrenceType` INT NOT NULL,
  `idTierLevel` INT NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  PRIMARY KEY (`idSubscriptions`),
  INDEX `fk_subscriptions_recurrenceType1_idx` (`idRecurrenceType` ASC) VISIBLE,
  INDEX `fk_subscriptions_tierLevel1_idx` (`idTierLevel` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_recurrenceType1`
    FOREIGN KEY (`idRecurrenceType`)
    REFERENCES `proyecto1_BD`.`recurrenceType` (`idRecurrenceType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_tierLevel1`
    FOREIGN KEY (`idTierLevel`)
    REFERENCES `proyecto1_BD`.`tierLevel` (`idTierLevel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`partnerProgram`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`partnerProgram` (
  `idPartnerProgram` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idPartnerProgram`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`Channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`Channel` (
  `idChannel` BIGINT NOT NULL AUTO_INCREMENT,
  `displayName` VARCHAR(70) NOT NULL,
  `description` NVARCHAR(500) NULL,
  `pictureURL` VARCHAR(76) NULL,
  `idUser` BIGINT NOT NULL,
  `idPartnerProgram` INT NULL,
  PRIMARY KEY (`idChannel`),
  INDEX `fk_Channel_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_Channel_partnerProgram1_idx` (`idPartnerProgram` ASC) VISIBLE,
  CONSTRAINT `fk_Channel_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Channel_partnerProgram1`
    FOREIGN KEY (`idPartnerProgram`)
    REFERENCES `proyecto1_BD`.`partnerProgram` (`idPartnerProgram`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`subscriptionsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`subscriptionsPerUser` (
  `idUser` BIGINT NOT NULL,
  `idSubscriptions` INT NOT NULL,
  `idChannel` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `nextTime` DATETIME NOT NULL,
  `streak` INT NOT NULL,
  INDEX `fk_subscriptionsPerUser_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_subscriptionsPerUser_subscriptions1_idx` (`idSubscriptions` ASC) VISIBLE,
  INDEX `fk_subscriptionsPerUser_Channel1_idx` (`idChannel` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptionsPerUser_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptionsPerUser_subscriptions1`
    FOREIGN KEY (`idSubscriptions`)
    REFERENCES `proyecto1_BD`.`subscriptions` (`idSubscriptions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptionsPerUser_Channel1`
    FOREIGN KEY (`idChannel`)
    REFERENCES `proyecto1_BD`.`Channel` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`benefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`benefits` (
  `idBenefits` INT NOT NULL,
  `name` VARCHAR(55) NOT NULL,
  `description` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idBenefits`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`categories` (
  `idCategories` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`idCategories`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`VideoQuality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`VideoQuality` (
  `idvideoQuality` INT NOT NULL AUTO_INCREMENT,
  `quality` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idvideoQuality`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`AllowedDatatypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`AllowedDatatypes` (
  `idalloweddatatype` INT NOT NULL AUTO_INCREMENT,
  `datatype` VARCHAR(50) NULL,
  PRIMARY KEY (`idalloweddatatype`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`Videos` (
  `idvideo` BIGINT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(300) NOT NULL,
  `size` DECIMAL(10,2) NOT NULL,
  `length` INT NOT NULL,
  `videoQualityId` INT NOT NULL,
  `alloweddatatypeid` INT NOT NULL,
  `idStreams` BIGINT NOT NULL,
  PRIMARY KEY (`idvideo`),
  INDEX `fk_Videos_VideoQuality1_idx` (`videoQualityId` ASC) VISIBLE,
  INDEX `fk_Videos_AllowedDatatypes1_idx` (`alloweddatatypeid` ASC) VISIBLE,
  INDEX `fk_Videos_streams1` (`idStreams` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_VideoQuality1`
    FOREIGN KEY (`videoQualityId`)
    REFERENCES `proyecto1_BD`.`VideoQuality` (`idvideoQuality`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_AllowedDatatypes1`
    FOREIGN KEY (`alloweddatatypeid`)
    REFERENCES `proyecto1_BD`.`AllowedDatatypes` (`idalloweddatatype`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `proyecto1_BD`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`streams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`streams` (
  `idStreams` BIGINT NOT NULL AUTO_INCREMENT,
  `title` NVARCHAR(200) NOT NULL,
  `viewers` BIGINT NULL,
  `date` DATETIME NOT NULL,
  `live` BIT NOT NULL,
  `endedDate` DATETIME NULL,
  `averageViewers` INT NULL,
  `maxiumViewers` INT NULL,
  `deleted` BIT NOT NULL,
  `storageLimitDate` DATETIME NULL,
  `idCategories` INT NOT NULL,
  `idChannel` BIGINT NOT NULL,
  PRIMARY KEY (`idStreams`),
  INDEX `fk_streams_categories1_idx` (`idCategories` ASC) VISIBLE,
  INDEX `fk_streams_Channel1_idx` (`idChannel` ASC) VISIBLE,
  CONSTRAINT `fk_streams_categories1`
    FOREIGN KEY (`idCategories`)
    REFERENCES `proyecto1_BD`.`categories` (`idCategories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_streams_Channel1`
    FOREIGN KEY (`idChannel`)
    REFERENCES `proyecto1_BD`.`Channel` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`UserStreamHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`UserStreamHistory` (
  `idUserStreamHistory` BIGINT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `exitDate` DATETIME NULL,
  `idUser` BIGINT NOT NULL,
  `idStreams` BIGINT NOT NULL,
  PRIMARY KEY (`idUserStreamHistory`),
  INDEX `fk_userRecord_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_userRecord_streams1_idx` (`idStreams` ASC) VISIBLE,
  CONSTRAINT `fk_userRecord_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userRecord_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `proyecto1_BD`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`tags` (
  `idTags` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTags`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`TagsPerStream`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`TagsPerStream` (
  `idTags` INT NOT NULL,
  `idStreams` BIGINT NOT NULL,
  INDEX `fk_TagsXCategories_tags1_idx` (`idTags` ASC) VISIBLE,
  INDEX `fk_TagsPerStream_streams1_idx` (`idStreams` ASC) VISIBLE,
  CONSTRAINT `fk_TagsXCategories_tags1`
    FOREIGN KEY (`idTags`)
    REFERENCES `proyecto1_BD`.`tags` (`idTags`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TagsPerStream_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `proyecto1_BD`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`supportAssociate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`supportAssociate` (
  `idSupportAssociate` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idSupportAssociate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`roles` (
  `idRoles` INT NOT NULL,
  `name` VARCHAR(55) NOT NULL,
  `description` VARCHAR(76) NOT NULL,
  `idSupportAssociate` INT NOT NULL,
  PRIMARY KEY (`idRoles`),
  INDEX `fk_roles_supportAssociate1_idx` (`idSupportAssociate` ASC) VISIBLE,
  CONSTRAINT `fk_roles_supportAssociate1`
    FOREIGN KEY (`idSupportAssociate`)
    REFERENCES `proyecto1_BD`.`supportAssociate` (`idSupportAssociate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`permissions` (
  `idPermissions` INT NOT NULL,
  `name` VARCHAR(55) NOT NULL,
  `description` VARCHAR(76) NOT NULL,
  `CODE` VARCHAR(76) NOT NULL,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  PRIMARY KEY (`idPermissions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`permissionsPerRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`permissionsPerRole` (
  `idPermissionsPerRole` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `deleted` BIT NOT NULL,
  `lastUpdate` DATETIME NULL,
  `userInCharge` VARCHAR(45) NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `idPermissions` INT NOT NULL,
  `idRoles` INT NOT NULL,
  PRIMARY KEY (`idPermissionsPerRole`),
  INDEX `fk_permissionsPerRole_permissions1_idx` (`idPermissions` ASC) VISIBLE,
  INDEX `fk_permissionsPerRole_roles1_idx` (`idRoles` ASC) VISIBLE,
  CONSTRAINT `fk_permissionsPerRole_permissions1`
    FOREIGN KEY (`idPermissions`)
    REFERENCES `proyecto1_BD`.`permissions` (`idPermissions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissionsPerRole_roles1`
    FOREIGN KEY (`idRoles`)
    REFERENCES `proyecto1_BD`.`roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`rolesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`rolesPerUser` (
  `idRolesPerUser` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `deleted` BIT NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `ipAddress` BIGINT NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `lastUpdate` DATETIME NULL,
  `roles_idRoles` INT NOT NULL,
  PRIMARY KEY (`idRolesPerUser`),
  INDEX `fk_rolesPerUser_roles1_idx` (`roles_idRoles` ASC) VISIBLE,
  CONSTRAINT `fk_rolesPerUser_roles1`
    FOREIGN KEY (`roles_idRoles`)
    REFERENCES `proyecto1_BD`.`roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`permissionsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`permissionsPerUser` (
  `idPermissionsPerUser` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `deleted` BIT NOT NULL,
  `lastUpdate` DATETIME NULL,
  `userInCharge` VARCHAR(45) NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `idPermissions` INT NOT NULL,
  `idSupportAssociate` INT NOT NULL,
  PRIMARY KEY (`idPermissionsPerUser`),
  INDEX `fk_permissionsPerUser_permissions1_idx` (`idPermissions` ASC) VISIBLE,
  INDEX `fk_permissionsPerUser_supportAssociate1_idx` (`idSupportAssociate` ASC) VISIBLE,
  CONSTRAINT `fk_permissionsPerUser_permissions1`
    FOREIGN KEY (`idPermissions`)
    REFERENCES `proyecto1_BD`.`permissions` (`idPermissions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissionsPerUser_supportAssociate1`
    FOREIGN KEY (`idSupportAssociate`)
    REFERENCES `proyecto1_BD`.`supportAssociate` (`idSupportAssociate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`ratings` (
  `idRating` INT NOT NULL AUTO_INCREMENT,
  `rating` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idStreamer` BIGINT NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `ipAddress` BIGINT NOT NULL,
  PRIMARY KEY (`idRating`),
  INDEX `fk_ratings_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_ratings_users2_idx` (`idStreamer` ASC) VISIBLE,
  CONSTRAINT `fk_ratings_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ratings_users2`
    FOREIGN KEY (`idStreamer`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`benefitsPerTierLevel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`benefitsPerTierLevel` (
  `idTierLevel` INT NOT NULL,
  `idBenefits` INT NOT NULL,
  INDEX `fk_benefitsPerTierLevel_tierLevel1_idx` (`idTierLevel` ASC) VISIBLE,
  CONSTRAINT `fk_benefitsPerTierLevel_tierLevel1`
    FOREIGN KEY (`idTierLevel`)
    REFERENCES `proyecto1_BD`.`tierLevel` (`idTierLevel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benefitsPerTierLevel_benefits1`
    FOREIGN KEY (`idBenefits`)
    REFERENCES `proyecto1_BD`.`benefits` (`idBenefits`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`donations` (
  `idDonations` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `message` VARCHAR(77) NULL,
  `checksum` VARBINARY(300) NOT NULL,
  PRIMARY KEY (`idDonations`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`donationsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`donationsPerUser` (
  `idUser` BIGINT NOT NULL,
  `idDonations` INT NOT NULL,
  `idChannel` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  INDEX `fk_donationsPerUser_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_donationsPerUser_donations1_idx` (`idDonations` ASC) VISIBLE,
  INDEX `fk_donationsPerUser_Channel1_idx` (`idChannel` ASC) VISIBLE,
  CONSTRAINT `fk_donationsPerUser_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donationsPerUser_donations1`
    FOREIGN KEY (`idDonations`)
    REFERENCES `proyecto1_BD`.`donations` (`idDonations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donationsPerUser_Channel1`
    FOREIGN KEY (`idChannel`)
    REFERENCES `proyecto1_BD`.`Channel` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`blackList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`BlackList` (
  `idStreamer` BIGINT NOT NULL,
  `idUser` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  INDEX `fk_blackList_users1_idx` (`idStreamer` ASC) VISIBLE,
  INDEX `fk_blackList_users2_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_blackList_users1`
    FOREIGN KEY (`idStreamer`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blackList_users2`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`ticket` (
  `idTicket` INT NOT NULL AUTO_INCREMENT,
  `issue` VARCHAR(75) NOT NULL,
  `resolved` BIT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `contactMethod` VARCHAR(55) NOT NULL,
  `idSupportAssociate` INT NOT NULL,
  `idUser` BIGINT NOT NULL,
  PRIMARY KEY (`idTicket`),
  INDEX `fk_ticket_supportAssociate1_idx` (`idSupportAssociate` ASC) VISIBLE,
  INDEX `fk_ticket_users1_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_supportAssociate1`
    FOREIGN KEY (`idSupportAssociate`)
    REFERENCES `proyecto1_BD`.`supportAssociate` (`idSupportAssociate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`Pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`Pictures` (
  `idPictures` BIGINT NOT NULL AUTO_INCREMENT,
  `URL` VARCHAR(76) NOT NULL,
  `PostTime` DATETIME NOT NULL,
  PRIMARY KEY (`idPictures`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`PicturesPerStream`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`PicturesPerStream` (
  `idPicturesPerStream` BIGINT NOT NULL AUTO_INCREMENT,
  `idPictures` BIGINT NOT NULL,
  `idStreams` BIGINT NOT NULL,
  PRIMARY KEY (`idPicturesPerStream`),
  INDEX `fk_PicturesPerStream_Pictures1_idx` (`idPictures` ASC) VISIBLE,
  INDEX `fk_PicturesPerStream_streams1_idx` (`idStreams` ASC) VISIBLE,
  CONSTRAINT `fk_PicturesPerStream_Pictures1`
    FOREIGN KEY (`idPictures`)
    REFERENCES `proyecto1_BD`.`Pictures` (`idPictures`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PicturesPerStream_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `proyecto1_BD`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`balances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`balances` (
  `idbalance` BIGINT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `lastUpdate` DATETIME NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idStreamer` BIGINT NOT NULL,
  `idMerchants` INT NOT NULL,
  `xtreamPercentage` DECIMAL(5,2) NULL,
  PRIMARY KEY (`idbalance`),
  INDEX `fk_balances_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_balances_merchants1_idx` (`idMerchants` ASC) VISIBLE,
  INDEX `fk_balances_users2_idx` (`idStreamer` ASC) VISIBLE,
  CONSTRAINT `fk_balances_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_balances_merchants1`
    FOREIGN KEY (`idMerchants`)
    REFERENCES `proyecto1_BD`.`merchants` (`idMerchants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_balances_users2`
    FOREIGN KEY (`idStreamer`)
    REFERENCES `proyecto1_BD`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto1_BD`.`benefitsPerPartnerProgram`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto1_BD`.`benefitsPerPartnerProgram` (
  `idPartnerProgram` INT NOT NULL,
  `idBenefits` INT NOT NULL,
  INDEX `fk_benefitsPerPartnerProgram_partnerProgram1_idx` (`idPartnerProgram` ASC) VISIBLE,
  INDEX `fk_benefitsPerPartnerProgram_benefits1_idx` (`idBenefits` ASC) VISIBLE,
  CONSTRAINT `fk_benefitsPerPartnerProgram_partnerProgram1`
    FOREIGN KEY (`idPartnerProgram`)
    REFERENCES `proyecto1_BD`.`partnerProgram` (`idPartnerProgram`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benefitsPerPartnerProgram_benefits1`
    FOREIGN KEY (`idBenefits`)
    REFERENCES `proyecto1_BD`.`benefits` (`idBenefits`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
