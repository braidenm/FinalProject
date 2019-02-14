-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema doggytinderdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `doggytinderdb` ;

-- -----------------------------------------------------
-- Schema doggytinderdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doggytinderdb` DEFAULT CHARACTER SET utf8 ;
USE `doggytinderdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL DEFAULT 'standard',
  `email` VARCHAR(100) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `banned` TINYINT NOT NULL DEFAULT 0,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` VARCHAR(45) NULL,
  `address_id` INT NULL,
  `age` INT NULL,
  `url` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_to_address_idx` (`address_id` ASC),
  CONSTRAINT `fk_user_to_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dog` ;

CREATE TABLE IF NOT EXISTS `dog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `breed` VARCHAR(45) NULL,
  `weight` INT NULL,
  `energy` INT NULL,
  `age` INT NULL,
  `about` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dog_to_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_dog_to_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `photo` ;

CREATE TABLE IF NOT EXISTS `photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dog_id` INT NOT NULL,
  `url` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_photo_to_dog_idx` (`dog_id` ASC),
  CONSTRAINT `fk_photo_to_dog`
    FOREIGN KEY (`dog_id`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `like` ;

CREATE TABLE IF NOT EXISTS `like` (
  `this_dog` INT NOT NULL,
  `that_dog` INT NOT NULL,
  PRIMARY KEY (`this_dog`, `that_dog`),
  INDEX `fk_liked_dog_idx` (`that_dog` ASC),
  CONSTRAINT `fk_liking_dog`
    FOREIGN KEY (`this_dog`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_liked_dog`
    FOREIGN KEY (`that_dog`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dislike`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dislike` ;

CREATE TABLE IF NOT EXISTS `dislike` (
  `this_dog` INT NOT NULL,
  `that_dog` INT NOT NULL,
  PRIMARY KEY (`this_dog`, `that_dog`),
  INDEX `fk_to_that_dog_idx` (`that_dog` ASC),
  CONSTRAINT `fk_to_this_dog`
    FOREIGN KEY (`this_dog`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_that_dog`
    FOREIGN KEY (`that_dog`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `match` ;

CREATE TABLE IF NOT EXISTS `match` (
  `dog1_id` INT NOT NULL,
  `dog2_id` INT NOT NULL,
  PRIMARY KEY (`dog1_id`, `dog2_id`),
  INDEX `fk_match_to_dog2_idx` (`dog2_id` ASC),
  CONSTRAINT `fk_match_to_dog1`
    FOREIGN KEY (`dog1_id`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_match_to_dog2`
    FOREIGN KEY (`dog2_id`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `preferences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `preferences` ;

CREATE TABLE IF NOT EXISTS `preferences` (
  `dog_id` INT NOT NULL,
  `min_weight` INT NULL,
  `max_weight` INT NULL,
  `min_energy` INT NULL,
  `max_energy` INT NULL,
  `min_age` INT NULL,
  `max_age` INT NULL,
  PRIMARY KEY (`dog_id`),
  CONSTRAINT `fk_to_dog`
    FOREIGN KEY (`dog_id`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  `text` VARCHAR(500) NULL,
  `time_sent` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_to_receiver_idx` (`receiver_id` ASC),
  CONSTRAINT `fk_to_sender`
    FOREIGN KEY (`sender_id`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_receiver`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `dog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS admin;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'admin' IDENTIFIED BY 'admin';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'admin';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
