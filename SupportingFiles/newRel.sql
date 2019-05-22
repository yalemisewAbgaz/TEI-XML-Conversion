-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema TEI_XML_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TEI_XML_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TEI_XML_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `TEI_XML_db` ;

-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Citation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Citation` (
  `citationId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  `n` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`citationId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Definition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Definition` (
  `definitionId` INT(11) NOT NULL AUTO_INCREMENT,
  `lang` VARCHAR(50) NULL DEFAULT NULL,
  `corresp` VARCHAR(50) NULL DEFAULT NULL,
  `definition` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`definitionId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Entry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Entry` (
  `entryId` INT(11) NOT NULL AUTO_INCREMENT,
  `id` VARCHAR(200) NOT NULL,
  `lang` CHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`entryId`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Form`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Form` (
  `formId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  `n` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`formId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`GrammarGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`GrammarGroup` (
  `grammarGroupId` INT(11) NOT NULL AUTO_INCREMENT,
  `gram` VARCHAR(50) NULL DEFAULT NULL,
  `pos` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`grammarGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Note` (
  `noteId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  `resp` VARCHAR(200) NULL DEFAULT NULL,
  `corresp` VARCHAR(50) NULL DEFAULT NULL,
  `note` VARCHAR(300) NULL DEFAULT NULL,
  `entryid` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`noteId`),
  INDEX `Entry_idx` (`entryid` ASC) VISIBLE,
  CONSTRAINT `NoteEntry`
    FOREIGN KEY (`entryid`)
    REFERENCES `TEI_XML_db`.`entry` (`entryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Place` (
  `placeId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `id` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`placeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Reference` (
  `referenceId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  `ref` VARCHAR(300) NULL DEFAULT NULL,
  `date` VARCHAR(20) NULL DEFAULT NULL COMMENT 'This field needs further treatment as there are dates of various formats in the tei/xml file.',
  `Entry_entryId` INT(11) NOT NULL,
  PRIMARY KEY (`referenceId`, `Entry_entryId`),
  INDEX `fk_Reference_Entry1_idx` (`Entry_entryId` ASC) VISIBLE,
  CONSTRAINT `fk_Reference_Entry1`
    FOREIGN KEY (`Entry_entryId`)
    REFERENCES `TEI_XML_db`.`Entry` (`entryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`Sense`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`Sense` (
  `senseId` INT(11) NOT NULL AUTO_INCREMENT,
  `corresp` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`senseId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`orth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`orth` (
  `orthId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  `orth` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`orthId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`pronunciation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`pronunciation` (
  `pronunciationId` INT(11) NOT NULL AUTO_INCREMENT,
  `notation` VARCHAR(50) NULL DEFAULT NULL,
  `resp` VARCHAR(50) NULL DEFAULT NULL,
  `change` VARCHAR(50) NULL DEFAULT NULL,
  `pron` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`pronunciationId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `TEI_XML_db`.`usage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TEI_XML_db`.`usage` (
  `usageId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`usageId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
