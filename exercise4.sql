-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Field_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `Name` VARCHAR(45) NOT NULL,
  `DOB` DATE NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_No` VARCHAR(20) NOT NULL,
  `Salary` FLOAT NOT NULL,
  `Specialist_Field_area` INT NOT NULL,
  PRIMARY KEY (`Name`, `Specialist_Field_area`),
  UNIQUE INDEX `Phone_No_UNIQUE` (`Phone_No` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_Field_area` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_Field_area`)
    REFERENCES `mydb`.`Specialist` (`Field_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Overtime_rate` INT NOT NULL,
  `Doctor_Name` VARCHAR(45) NOT NULL,
  `Doctor_Specialist_Field_area` INT NOT NULL,
  PRIMARY KEY (`Overtime_rate`, `Doctor_Name`, `Doctor_Specialist_Field_area`),
  INDEX `fk_Medical_Doctor1_idx` (`Doctor_Name` ASC, `Doctor_Specialist_Field_area` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_Doctor1`
    FOREIGN KEY (`Doctor_Name` , `Doctor_Specialist_Field_area`)
    REFERENCES `mydb`.`Doctor` (`Name` , `Specialist_Field_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `DOB` DATE NOT NULL,
  `Phone_No` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Date` DATE NOT NULL,
  `Time` VARCHAR(45) NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  `Doctor_Name1` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Date`, `Time`, `Patient_Name`, `Doctor_Name1`),
  INDEX `fk_Appointment_Patient_idx` (`Patient_Name` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor2_idx` (`Doctor_Name1` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient`
    FOREIGN KEY (`Patient_Name`)
    REFERENCES `mydb`.`Patient` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor2`
    FOREIGN KEY (`Doctor_Name1`)
    REFERENCES `mydb`.`Doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Details` VARCHAR(45) NOT NULL,
  `Method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Details`, `Method`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Total` FLOAT NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Total`, `Patient_Name`),
  INDEX `fk_Bill_Patient1_idx` (`Patient_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Patient1`
    FOREIGN KEY (`Patient_Name`)
    REFERENCES `mydb`.`Patient` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill_has_Payment` (
  `Bill_Total` FLOAT NOT NULL,
  `Bill_Patient_Name` VARCHAR(45) NOT NULL,
  `Payment_Details` VARCHAR(45) NOT NULL,
  `Payment_Method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Bill_Total`, `Bill_Patient_Name`, `Payment_Details`, `Payment_Method`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_Details` ASC, `Payment_Method` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_Total` ASC, `Bill_Patient_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_Total` , `Bill_Patient_Name`)
    REFERENCES `mydb`.`Bill` (`Total` , `Patient_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_Details` , `Payment_Method`)
    REFERENCES `mydb`.`Payment` (`Details` , `Method`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
