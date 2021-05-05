-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema XtreamDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema XtreamDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `XtreamDB` DEFAULT CHARACTER SET utf8 ;
USE `XtreamDB` ;

-- -----------------------------------------------------
-- Table `XtreamDB`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`users` (
  `idUser` BIGINT NOT NULL AUTO_INCREMENT,
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
-- Table `XtreamDB`.`merchants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`merchants` (
  `idMerchants` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  `merchantURL` VARCHAR(76) NOT NULL,
  `iconURL` VARCHAR(76) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`idMerchants`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`paymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`paymentStatus` (
  `idPaymentStatus` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPaymentStatus`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `XtreamDB`.`paymentAttempts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`paymentAttempts` (
  `idPaymentAttempts` INT NOT NULL AUTO_INCREMENT,
  `postTime` DATETIME NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `referenceNumber` BIGINT NULL,
  `errorNumber` BIGINT NULL,
  `merchantTransactionNumber` BIGINT NOT NULL,
  `description` NVARCHAR(8000) NOT NULL,
  `paymentTimeStamp` DATETIME NOT NULL,
  `computerName` VARCHAR(55) NOT NULL,
  `ipAddress` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `currencySymbol` varchar (5) not null,
  `idUser` BIGINT NOT NULL,
  `idmerchants` INT NOT NULL,
  `idpaymentStatus` INT NOT NULL,
  PRIMARY KEY (`idPaymentAttempts`),
  INDEX `fk_paymentAttempts_users_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_paymentAttempts_merchants1_idx` (`idmerchants` ASC) VISIBLE,
  INDEX `fk_paymentAttempts_paymentStatus1_idx` (`idpaymentStatus` ASC) VISIBLE,
  CONSTRAINT `fk_paymentAttempts_users`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentAttempts_merchants1`
    FOREIGN KEY (`idmerchants`)
    REFERENCES `XtreamDB`.`merchants` (`idMerchants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentAttempts_paymentStatus1`
    FOREIGN KEY (`idpaymentStatus`)
    REFERENCES `XtreamDB`.`paymentStatus` (`idPaymentStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)	
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`recurrenceType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`recurrenceType` (
  `idRecurrenceType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  `valueToAdd` VARCHAR(45) NOT NULL,
  `datePart` VARCHAR(45) NULL,
  PRIMARY KEY (`idRecurrenceType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`tierLevel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`tierLevel` (
  `idTierLevel` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(75) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idTierLevel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`transactionType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`transactionType` (
  `idTransactionType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTransactionType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`transactionSubType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`transactionSubType` (
  `idTransactionSubType` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTransactionSubType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`paymentTransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`paymentTransactions` (
  `idPaymentTransactions` BIGINT NOT NULL AUTO_INCREMENT,
  `postTime` DATETIME NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `computerName` VARCHAR(45) NOT NULL,
  `ipAddress` VARCHAR(45) NOT NULL,
  `checksum` VARCHAR(45) NULL,
  `amount` DECIMAL(10,2) NULL,
  `referenceID` BIGINT NULL,
  `idUser` BIGINT NOT NULL,
  `idTransactionType` INT NOT NULL,
  `idTransactionSubType` INT NOT NULL,
  PRIMARY KEY (`idPaymentTransactions`),
  INDEX `fk_paymentTransactions_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_paymentTransactions_transactionType1_idx` (`idTransactionType` ASC) VISIBLE,
  INDEX `fk_paymentTransactions_transactionSubType1_idx` (`idTransactionSubType` ASC) VISIBLE,
  CONSTRAINT `fk_paymentTransactions_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentTransactions_transactionType1`
    FOREIGN KEY (`idTransactionType`)
    REFERENCES `XtreamDB`.`transactionType` (`idTransactionType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentTransactions_transactionSubType1`
    FOREIGN KEY (`idTransactionSubType`)
    REFERENCES `XtreamDB`.`transactionSubType` (`idTransactionSubType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`subscriptions` (
  `idSubscriptions` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(55) NOT NULL,
  `descriptionHTML` VARCHAR(128) NOT NULL,
  `startTime` DATETIME NOT NULL,
  `endTime` DATETIME NOT NULL,
  `enabled` BIT NOT NULL,
  `iconURL` VARCHAR(76) NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `idRecurrenceType` INT NOT NULL,
  `idTierLevel` INT NOT NULL,
  `idPaymentTransactions` BIGINT NOT NULL,
  PRIMARY KEY (`idSubscriptions`),
  INDEX `fk_subscriptions_recurrenceType1_idx` (`idRecurrenceType` ASC) VISIBLE,
  INDEX `fk_subscriptions_tierLevel1_idx` (`idTierLevel` ASC) VISIBLE,
  INDEX `fk_subscriptions_paymentTransactions1_idx` (`idPaymentTransactions` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_recurrenceType1`
    FOREIGN KEY (`idRecurrenceType`)
    REFERENCES `XtreamDB`.`recurrenceType` (`idRecurrenceType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_tierLevel1`
    FOREIGN KEY (`idTierLevel`)
    REFERENCES `XtreamDB`.`tierLevel` (`idTierLevel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_paymentTransactions1`
    FOREIGN KEY (`idPaymentTransactions`)
    REFERENCES `XtreamDB`.`paymentTransactions` (`idPaymentTransactions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`partnerProgram`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`partnerProgram` (
  `idPartnerProgram` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idPartnerProgram`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`Channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`Channel` (
  `idChannel` BIGINT NOT NULL AUTO_INCREMENT,
  `displayName` NVARCHAR(70) NOT NULL,
  `description` NVARCHAR(500) NULL,
  `pictureURL` VARCHAR(76) NULL,
  `currentSubscriberAmount` INT NULL,
  `live` BIT NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idPartnerProgram` INT NULL,
  PRIMARY KEY (`idChannel`),
  INDEX `fk_Channel_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_Channel_partnerProgram1_idx` (`idPartnerProgram` ASC) VISIBLE,
  CONSTRAINT `fk_Channel_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Channel_partnerProgram1`
    FOREIGN KEY (`idPartnerProgram`)
    REFERENCES `XtreamDB`.`partnerProgram` (`idPartnerProgram`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`subscriptionsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`subscriptionsPerUser` (
  `idUser` BIGINT NOT NULL AUTO_INCREMENT,
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
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptionsPerUser_subscriptions1`
    FOREIGN KEY (`idSubscriptions`)
    REFERENCES `XtreamDB`.`subscriptions` (`idSubscriptions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptionsPerUser_Channel1`
    FOREIGN KEY (`idChannel`)
    REFERENCES `XtreamDB`.`Channel` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`benefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`benefits` (
  `idBenefits` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  `description` VARCHAR(75) NOT NULL,
  `datatype` VARCHAR(45) NULL,
  `value` INT NULL,
  PRIMARY KEY (`idBenefits`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`categories` (
  `idCategories` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`idCategories`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`VideoQuality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`VideoQuality` (
  `idvideoQuality` INT NOT NULL AUTO_INCREMENT,
  `quality` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idvideoQuality`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`AllowedDatatypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`AllowedDatatypes` (
  `idalloweddatatype` INT NOT NULL AUTO_INCREMENT,
  `datatype` VARCHAR(50) NULL,
  PRIMARY KEY (`idalloweddatatype`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`Videos` (
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
    REFERENCES `XtreamDB`.`VideoQuality` (`idvideoQuality`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_AllowedDatatypes1`
    FOREIGN KEY (`alloweddatatypeid`)
    REFERENCES `XtreamDB`.`AllowedDatatypes` (`idalloweddatatype`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `XtreamDB`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`streams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`streams` (
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
    REFERENCES `XtreamDB`.`categories` (`idCategories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_streams_Channel1`
    FOREIGN KEY (`idChannel`)
    REFERENCES `XtreamDB`.`Channel` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`tags` (
  `idTags` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTags`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`TagsPerStream`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`TagsPerStream` (
  `idTagsPerStream` INT NOT NULL AUTO_INCREMENT,
  `idTags` INT NOT NULL,
  `idStreams` BIGINT NOT NULL,
  PRIMARY KEY (`idTagsPerStream`),
  INDEX `fk_TagsXCategories_tags1_idx` (`idTags` ASC) VISIBLE,
  INDEX `fk_TagsPerStream_streams1_idx` (`idStreams` ASC) VISIBLE,
  CONSTRAINT `fk_TagsXCategories_tags1`
    FOREIGN KEY (`idTags`)
    REFERENCES `XtreamDB`.`tags` (`idTags`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TagsPerStream_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `XtreamDB`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`roles` (
  `idRoles` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  `description` VARCHAR(76) NOT NULL,
  PRIMARY KEY (`idRoles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`permissions` (
  `idPermissions` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  `description` VARCHAR(76) NOT NULL,
  `CODE` VARCHAR(76) NOT NULL,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  PRIMARY KEY (`idPermissions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`permissionsPerRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`permissionsPerRole` (
  `idPermissionsPerRole` INT NOT NULL AUTO_INCREMENT,
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
    REFERENCES `XtreamDB`.`permissions` (`idPermissions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissionsPerRole_roles1`
    FOREIGN KEY (`idRoles`)
    REFERENCES `XtreamDB`.`roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`rolesPerAssociate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`rolesPerAssociate` (
  `idRolesPerAssociate` INT NOT NULL AUTO_INCREMENT,
  `postTime` DATETIME NOT NULL,
  `deleted` BIT NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `ipAddress` VARCHAR(45) NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `lastUpdate` DATETIME NULL,
  `idRoles` INT NOT NULL,
  `idUser` BIGINT NOT NULL,
  PRIMARY KEY (`idRolesPerAssociate`),
  INDEX `fk_rolesPerUser_roles1_idx` (`idRoles` ASC) VISIBLE,
  INDEX `fk_rolesPerAssociate_users1_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_rolesPerUser_roles1`
    FOREIGN KEY (`idRoles`)
    REFERENCES `XtreamDB`.`roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolesPerAssociate_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`permissionsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`permissionsPerUser` (
  `idPermissionsPerAssociate` INT NOT NULL AUTO_INCREMENT,
  `postTime` DATETIME NOT NULL,
  `deleted` BIT NOT NULL,
  `lastUpdate` DATETIME NULL,
  `userInCharge` VARCHAR(45) NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `idPermissions` INT NOT NULL,
  `idUser` BIGINT NOT NULL,
  PRIMARY KEY (`idPermissionsPerAssociate`),
  INDEX `fk_permissionsPerUser_permissions1_idx` (`idPermissions` ASC) VISIBLE,
  INDEX `fk_permissionsPerAssociate_users1_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_permissionsPerUser_permissions1`
    FOREIGN KEY (`idPermissions`)
    REFERENCES `XtreamDB`.`permissions` (`idPermissions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissionsPerAssociate_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`ratings` (
  `idRatings` INT NOT NULL AUTO_INCREMENT,
  `rating` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idStreamer` BIGINT NOT NULL,
  `checksum` VARCHAR(45) NOT NULL,
  `ipAddress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRatings`),
  INDEX `fk_ratings_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_ratings_users2_idx` (`idStreamer` ASC) VISIBLE,
  CONSTRAINT `fk_ratings_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ratings_users2`
    FOREIGN KEY (`idStreamer`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`benefitsPerTierLevel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`benefitsPerTierLevel` (
  `idBenefitsPerTierLevel` INT NOT NULL AUTO_INCREMENT,
  `idTierLevel` INT NOT NULL,
  `idBenefits` INT NOT NULL,
  INDEX `fk_benefitsPerTierLevel_tierLevel1_idx` (`idTierLevel` ASC) VISIBLE,
  PRIMARY KEY (`idBenefitsPerTierLevel`),
  CONSTRAINT `fk_benefitsPerTierLevel_tierLevel1`
    FOREIGN KEY (`idTierLevel`)
    REFERENCES `XtreamDB`.`tierLevel` (`idTierLevel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benefitsPerTierLevel_benefits1`
    FOREIGN KEY (`idBenefits`)
    REFERENCES `XtreamDB`.`benefits` (`idBenefits`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`donations` (
  `idDonations` BIGINT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `message` VARCHAR(77) NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `idPaymentTransactions` BIGINT NOT NULL,
  PRIMARY KEY (`idDonations`),
  INDEX `fk_donations_paymentTransactions1_idx` (`idPaymentTransactions` ASC) VISIBLE,
  CONSTRAINT `fk_donations_paymentTransactions1`
    FOREIGN KEY (`idPaymentTransactions`)
    REFERENCES `XtreamDB`.`paymentTransactions` (`idPaymentTransactions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`donationsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`donationsPerUser` (
  `idUser` BIGINT NOT NULL AUTO_INCREMENT,
  `idDonations` BIGINT NOT NULL,
  `idChannel` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  INDEX `fk_donationsPerUser_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_donationsPerUser_donations1_idx` (`idDonations` ASC) VISIBLE,
  INDEX `fk_donationsPerUser_Channel1_idx` (`idChannel` ASC) VISIBLE,
  CONSTRAINT `fk_donationsPerUser_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donationsPerUser_donations1`
    FOREIGN KEY (`idDonations`)
    REFERENCES `XtreamDB`.`donations` (`idDonations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donationsPerUser_Channel1`
    FOREIGN KEY (`idChannel`)
    REFERENCES `XtreamDB`.`Channel` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`blackList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`BlackList` (
  `idStreamer` BIGINT NOT NULL AUTO_INCREMENT,
  `idUser` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  INDEX `fk_blackList_users1_idx` (`idStreamer` ASC) VISIBLE,
  INDEX `fk_blackList_users2_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_blackList_users1`
    FOREIGN KEY (`idStreamer`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blackList_users2`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`ticket` (
  `idTicket` INT NOT NULL AUTO_INCREMENT,
  `issue` VARCHAR(75) NOT NULL,
  `resolved` BIT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `contactMethod` VARCHAR(55) NOT NULL,
  `idSupportAssociate` INT NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idUserSupport` BIGINT NOT NULL,
  PRIMARY KEY (`idTicket`),
  INDEX `fk_ticket_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_ticket_users2_idx` (`idUserSupport` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_users2`
    FOREIGN KEY (`idUserSupport`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`Pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`Pictures` (
  `idPictures` BIGINT NOT NULL AUTO_INCREMENT,
  `URL` VARCHAR(76) NOT NULL,
  `PostTime` DATETIME NOT NULL,
  PRIMARY KEY (`idPictures`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`PicturesPerStream`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`PicturesPerStream` (
  `idPicturesPerStream` BIGINT NOT NULL AUTO_INCREMENT,
  `idPictures` BIGINT NOT NULL,
  `idStreams` BIGINT NOT NULL,
  PRIMARY KEY (`idPicturesPerStream`),
  INDEX `fk_PicturesPerStream_Pictures1_idx` (`idPictures` ASC) VISIBLE,
  INDEX `fk_PicturesPerStream_streams1_idx` (`idStreams` ASC) VISIBLE,
  CONSTRAINT `fk_PicturesPerStream_Pictures1`
    FOREIGN KEY (`idPictures`)
    REFERENCES `XtreamDB`.`Pictures` (`idPictures`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PicturesPerStream_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `XtreamDB`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`benefitsPerPartnerProgram`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`benefitsPerPartnerProgram` (
  `idPartnerProgram` INT NOT NULL AUTO_INCREMENT,
  `idBenefits` INT NOT NULL,
  INDEX `fk_benefitsPerPartnerProgram_partnerProgram1_idx` (`idPartnerProgram` ASC) VISIBLE,
  INDEX `fk_benefitsPerPartnerProgram_benefits1_idx` (`idBenefits` ASC) VISIBLE,
  CONSTRAINT `fk_benefitsPerPartnerProgram_partnerProgram1`
    FOREIGN KEY (`idPartnerProgram`)
    REFERENCES `XtreamDB`.`partnerProgram` (`idPartnerProgram`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benefitsPerPartnerProgram_benefits1`
    FOREIGN KEY (`idBenefits`)
    REFERENCES `XtreamDB`.`benefits` (`idBenefits`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`StreamEventType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`StreamEventType` (
  `idStreamEventType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idStreamEventType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XtreamDB`.`StreamLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XtreamDB`.`StreamLog` (
  `idStreamLog` BIGINT NOT NULL AUTO_INCREMENT,
  `PostTime` DATETIME NOT NULL,
  `EndTime` DATETIME NULL,
  `idStreams` BIGINT NOT NULL,
  `idUser` BIGINT NOT NULL,
  `idStreamEventType` INT NOT NULL,
  PRIMARY KEY (`idStreamLog`),
  INDEX `fk_StreamLog_streams1_idx` (`idStreams` ASC) VISIBLE,
  INDEX `fk_StreamLog_users1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_StreamLog_StreamEventType1_idx` (`idStreamEventType` ASC) VISIBLE,
  CONSTRAINT `fk_StreamLog_streams1`
    FOREIGN KEY (`idStreams`)
    REFERENCES `XtreamDB`.`streams` (`idStreams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StreamLog_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `XtreamDB`.`users` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StreamLog_StreamEventType1`
    FOREIGN KEY (`idStreamEventType`)
    REFERENCES `XtreamDB`.`StreamEventType` (`idStreamEventType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Script de llenado
insert into users (idUser, firstname, lastname, username, email, verified, password, checksum)
values(1,"Lolo", "Fernández", "LolitoFNDZ", "lolencioElCrack@gmail.com",1, 100010101001001110,"0x62736A696F"),
(2,"Taylor", "Hernández", "TAY-LORD_OF_THE_HELL", "taylor20sep.hc@gmail.com",0, 1101011001000,"0x669EB8A696F"),
(3,"Juan", "Vargas", "Fletes_Baratos", "juanVF@Yopmail.com",0, 100001011010111,"0x235FA4D89D3"),
(4,"Yuen", "Law", "Yuen777", "yuenlawTEC@Yopmail.com",1, 101110011010101,"0x3521BA7C459D"),
(5,"Alejandro", "Castro", "Don_Simon", "alejandro_gamer666@hotmail.com",0, 11101100000,"0x214CC7D958A"),
(6,"Ruben", "Viquez", "RubiusUwU", "rubiuNoSeasMalo@gmail.com",1, 1111110000001,"0x2A45D1D9581"),
(7,"Carlos", "Alvarado", "Charly_God", "ElPresi666@hotmail.com",0, 10000110001,"0x75ACB66BD20"),
(8,"Florentino", "Perez", "FlorentiNop", "florentinoPerez123@gmail.com",1, 101010111000,"0x123BDB66B01A"),
(9,"Francisco", "Franco", "xX_Franchesco_Xx", "arribaFranco@gmail.com",1, 1001011000101,"0x41C2ABF45E"),
(10,"Luis", "Miguel", "eLSolazo", "luismiguelelcrack@hotmail.com",0, 1110010110100,"0x541AB2CCF12");

insert into Channel ( `idChannel`,`displayName` ,`description` ,`pictureURL`,`live`,`idUser`)
values(1,"Lolito", "Jejeje yepas jeje", "https://images.app.goo.gl/cpDD8XVikgPnEnJd9",0, 1),
(2,"Tay-Lord", "momento xd", "https://images.app.goo.gl/HNA2H1Vz1GDaoCrv9",0, 2),
(3,"Juancin", "Mi madre me dio la vida, pero Tusa las ganas de vivirla", "https://images.app.goo.gl/agBxQAekVfxux95A7",0, 3),
(4,"Yuen", "Lo unico más duro en esta vida que un algoritmo NP-Duro, es no tenerte baby", "https://images.app.goo.gl/ufMstNaYFzmno8GM6",0, 4),
(5,"Ale-Luya", "Simón", "https://images.app.goo.gl/iqNTDrC7zEkiZgn77",0, 5),
(6,"Rubiu", "ust ust", "https://images.app.goo.gl/EibfqZS5EPee3zJ3A",0, 6),
(7,"Charly Alvarado", "Un chuzo de mae", "https://images.app.goo.gl/VWkNwDSPrUwpDUrf7",0, 7),
(8,"Florentino", "Ni tan superman va a ser tan Super como mi liga. HALA MADRID!. SIUUUU", "https://images.app.goo.gl/gMuiRSMGrp7f9coe6", 0,8),
(9,"Franco", "Arriba España. Si España te ataca, no hay error, no hay error", "https://images.app.goo.gl/Di6caAhjUKbw8BKx7",0, 9),
(10,"LuisMi", "Si tú me hubieras dicho siempre la verdad, Si hubieras respondido cuando te llamé, Si hubieras amado cuando te amé, Serías en mis sueños la mejor mujer… ", "https://images.app.goo.gl/PudHayh5p9ZofEAfA",0, 10);

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

insert into transactionSubType(`name`)
values ("Donation");

insert into paymentStatus(name)
values("Accepted"),("In process"),("Declined");

insert into merchants(name,merchantURL,iconURL,enabled)
values ("McDonalds", "https://www.mcdonalds.co.cr/", "https://images.app.goo.gl/sAYT9hFoUUZT95Yb8", 1),
("Logitech", "https://www.logitechg.com/es-roam", "https://images.app.goo.gl/GYBj1xURa1KFocfC9", 1),
("Playstation", "https://www.playstation.com/es-cr/", "https://images.app.goo.gl/xnNZBeUWHr9QV4AU9", 1),
("Pollolandia", "https://pollolandia.com/cr/index.php/component/users/?view=remind", "https://images.app.goo.gl/KrWHY9WT4ZimErhx9", 0),
("Walmart", "https://walmart.co.cr/", "https://images.app.goo.gl/ruF2CG4vxZHjtY1E6", 0);