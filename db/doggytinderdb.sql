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
  `password` VARCHAR(500) NOT NULL,
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
  `enabled` TINYINT NOT NULL DEFAULT 1,
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
  `active` TINYINT NOT NULL DEFAULT 1,
  `sex` VARCHAR(45) NULL,
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
-- Table `likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `likes` ;

CREATE TABLE IF NOT EXISTS `likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `this_dog` INT NOT NULL,
  `that_dog` INT NOT NULL,
  INDEX `fk_liked_dog_idx` (`that_dog` ASC),
  PRIMARY KEY (`id`),
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `this_dog` INT NOT NULL,
  `that_dog` INT NOT NULL,
  INDEX `fk_to_that_dog_idx` (`that_dog` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_to_this_dog_idx` (`this_dog` ASC),
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
-- Table `matches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matches` ;

CREATE TABLE IF NOT EXISTS `matches` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dog1_id` INT NOT NULL,
  `dog2_id` INT NOT NULL,
  INDEX `fk_match_to_dog2_idx` (`dog2_id` ASC),
  PRIMARY KEY (`id`),
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `dog_id` INT NOT NULL,
  `min_weight` INT NULL,
  `max_weight` INT NULL,
  `min_energy` INT NULL,
  `max_energy` INT NULL,
  `min_age` INT NULL,
  `max_age` INT NULL,
  `sex` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
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
  `time_sent` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `opened` TINYINT NULL DEFAULT 0,
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
DROP USER IF EXISTS admin@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'admin'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (1, '7400 E Orchard Rd #1450n', 'Greenwood Village', 'Colorado', '80111');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (2, '50 Embarcadero Rd', 'Palo Alto', 'California', '94301');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (3, '140 S Broadway', 'Denver', 'Colorado', '80209');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (4, '1600 Pennsylvania', 'Washington, D.C.', 'District of Columbia', '20500');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (5, '3030 E 1st Ave', 'Denver', 'Colorado', '80206');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (6, '1155 S Havana St. #63', 'Denver', 'Colorado', '80012');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (7, '6855 S Dayton St.', 'Greenwood Village', 'Colorado', '80112');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (8, '7400 E Hampden Ave', 'Denver', 'Colorado', '80231');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (9, '1901 S Havana St', 'Denver', 'Colorado', '80014');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (10, '1160 Lincoln St', 'Denver', 'Colorado', '80203');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (11, '6499 Leetsdale Dr', 'Denver', 'Colorado', '80224');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (12, '4380 E Alameda Ave', 'Denver', 'Colorado', '80246');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (1, 'admin', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'admin', 'admin@admin.com', 1, 0, 'Administrius', 'Diggy', 'Male', 1, 40, 'https://cdn3.iconfinder.com/data/icons/gray-user-toolbar/512/oficcial-512.png', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (2, 'doglover', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'doglover@paws.com', 1, 0, 'Joan', 'Bayez', 'Female', 2, 78, 'https://d279m997dpfwgl.cloudfront.net/wp/2018/09/0910_baez-1000x743.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (3, 'thedogabides', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'thedogabides@dude.com', 1, 0, 'Jeff \"The Dude\"', 'Lebowski', 'Male', 3, 65, 'https://uproxx.files.wordpress.com/2019/02/the-dude-the-big-lebowski.jpg?w=300&h=210&crop=1&quality=100', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (4, 'number44', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', '44@whitehouse.gov', 1, 0, 'Barack', 'Obama', 'Male', 4, 57, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE4MDAzNDEwNzg5ODI4MTEw/barack-obama-12782369-1-402.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (5, 'doggonecrazy', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'crazyfordogs@dog.com', 1, 0, 'Sarah', 'Parker', 'Female', 5, 52, 'https://timedotcom.files.wordpress.com/2014/11/sarah-jessica-parker.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (6, 'puppermintpatty', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'puppermintpatty@dog.com', 1, 0, 'Patty', 'Peppermint', 'Female', 6, 39, 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a0/Peppermint_Patty.png/170px-Peppermint_Patty.png', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (7, 'danceswithdogs', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'runswithdogs@dog.com', 1, 0, 'Kevin', 'Costner', 'Male', 7, 64, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NDg0MDU0OTMzNTA1NTUx/kevin-costner-9258776-1-402.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (8, 'thedogwhisperer', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'dogwhisperer@dog.com', 1, 0, 'Cesar', 'Millan', 'Male', 8, 49, 'https://pbs.twimg.com/profile_images/1028109745356304384/QAttxEQ1_400x400.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (9, 'snoopdogg', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'snoopdiggitydogg@dwestcoast.com', 1, 0, 'Snoop', 'Dogg', 'Male', 9, 47, 'https://pbs.twimg.com/profile_images/943933166015803392/jvjasD7v_400x400.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (10, '50cent', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', '50cent@gunit.com', 1, 0, 'Curtis', 'Jackson', 'Male', 10, 43, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NDg0MDU1NDExNDU5NTk5/after-earth-new-york-premiere---inside-arrivals.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (11, 'usher', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'usher@sings.com', 1, 0, 'Usher', 'Raymond', 'Male', 11, 40, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTIwNjA4NjMzNDczNzYyODI4/95-106-capital-fm-summertime-ball-2012---media-run.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (12, 'wizkid', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'wizkid@music.com', 1, 0, 'Wiz', 'Khalifa', 'Male', 12, 31, 'https://www.billboard.com/files/media/Wiz-Khalifa-vanity-fair-2018-billboard-1548.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (13, 'dogperson', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'dogperson@aol.com', 1, 0, 'Bruce', 'Lee', 'Male', 2, 70, 'https://static1.squarespace.com/static/574dd66227d4bdb54a2f65e3/t/5ab57ee388251b2e6b2f6a74/1525457744682/BL_Website_ETD_rt_profile_store_v1.jpg?format=500w', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (14, 'doglady', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'doglady@aol.com', 1, 0, 'Alicia', 'Silverstone', 'Female', 2, 42, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE4MDAzNDEwMzI1NTA1NTUw/alicia-silverstone-240974-1-402.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (15, 'puppypal', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'puppypal@gmail.com', 1, 0, 'Macauley \"Macauley Culkin\"', 'Culkin', 'Male', 3, 38, 'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fewedit.files.wordpress.com%2F2018%2F12%2Frexfeatures_9919820ev.jpg%3Fw%3D2000&w=450&c=sc&poi=face&q=85', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (16, 'thedogwalker', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'thedogwalker@aol.com', 1, 0, 'Daniel', 'Radcliffe', 'Male', 4, 29, 'https://cdn.newsapi.com.au/image/v1/8a0864dbe33b623d3ea78252795be832', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (17, 'dogparkpatrol', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'dogparkpatrol@aol.com', 1, 0, 'Dwayne', 'Johnson', 'Male', 5, 46, 'http://www.gstatic.com/tv/thumb/persons/235135/235135_v9_ba.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (18, 'babybaby', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'itsbritneyb@aol.com', 1, 0, 'Britney', 'Spears', 'Female', 6, 37, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTQwMjY3NjU5MTk4NDczNDQ5/gettyimages-168582304_croppedjpg.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (19, 'idlehands', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'idlehands@devilswork.com', 1, 0, 'Dewon', 'Sawa', 'Male', 7, 40, 'http://www.gstatic.com/tv/thumb/persons/71648/71648_v9_bb.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (20, 'meansofproduction', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'meansofp@aol.com', 1, 0, 'Karl', 'Marx', 'Male', 8, 201, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE1ODA0OTcxNzE5NjI0MjA1/karl-marx-9401219-1-402.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (21, 'number16', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'number16@whitehouse.gov', 1, 0, 'Abraham', 'Lincoln', 'Male', 4, 210, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Abraham_Lincoln_O-77_matte_collodion_print.jpg/220px-Abraham_Lincoln_O-77_matte_collodion_print.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (22, 'jackfk', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'jackiedoesntknow@whitehouse.gov', 1, 0, 'John', 'Kennedy', 'Male', 4, 102, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Jfk2.jpg/1200px-Jfk2.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (23, 'teddyroo', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'teddytakesovertheworld@whitehosue.gov', 1, 0, 'Theodore', 'Roosevelt', 'Male', 4, 151, 'https://cdn.danspapers.com/wp-content/uploads/2018/04/Roosevelt5.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (24, 'fdr', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'fdr@whitehouse.gov', 1, 0, 'Franklin', 'Roosevelt', 'Male', 4, 67, 'https://upload.wikimedia.org/wikipedia/commons/4/42/FDR_1944_Color_Portrait.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (25, 'hillary', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'ready4hillary@home.com', 1, 0, 'Hillary', 'Clinton', 'Female', 5, 71, 'https://pixel.nymag.com/imgs/daily/intelligencer/2018/11/12/13-hillary-clinton-2020.w700.h700.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (26, 'ellieroo', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'ellieroo@brandeis.edu', 1, 0, 'Eleanor', 'Roosevelt', 'Female', 4, 90, 'https://aaregistry.org/wp-content/uploads/2014/09/eleanor-roosevelt-208x300.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (27, 'lizqueen', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'herroyalhighness@britain.eu', 1, 0, 'Elizabeth', 'Windsor', 'Female', 5, 92, 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Queen_Elizabeth_II_in_March_2015.jpg/1200px-Queen_Elizabeth_II_in_March_2015.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (28, 'bermerker', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'bermerker@deutschland.de', 1, 0, 'Angela', 'Merkel', 'Female', 5, 64, 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Angela_Merkel._Tallinn_Digital_Summit.jpg/220px-Angela_Merkel._Tallinn_Digital_Summit.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (29, 'philton', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'paris@hiltonhotels.com', 1, 0, 'Paris', 'Hilton', 'Female', 7, 38, 'http://www.gstatic.com/tv/thumb/persons/274397/274397_v9_ba.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (30, 'miley', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'wreckingball@gmail.com', 1, 0, 'Miley', 'Cyrus', 'Female', 8, 26, 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/miley-cyrus-attends-the-61st-annual-grammy-awards-at-news-photo-1128843805-1550509520.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (31, 'monster', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'monster@hollywood.com', 1, 0, 'Charlize', 'Theron', 'Female', 9, 43, 'http://www.gstatic.com/tv/thumb/persons/68310/68310_v9_bb.jpg', DEFAULT);
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`, `enabled`) VALUES (32, 'mariah', '$2a$10$RAAguk2wumgGSSHMm9rPoOLDkKx.lmsJcl1GWcFtKfb7MDU703Pdu', 'standard', 'mariah@diva.com', 1, 0, 'Mariah', 'Carey', 'Female', 10, 48, 'http://www.gstatic.com/tv/thumb/persons/68310/68310_v9_bb.jpg', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dog`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (1, 1, 'Asher', 'Mutt', 55, 7, 3, 'I\'m Jimmy\'s dog, probably one of the best dogs.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (2, 2, 'The Revolution', 'Chihuahua', 4, 8, 7, 'Yip! Yip!', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (3, 3, 'Little Dude', 'Bulldog', 45, 2, 4, 'I abide.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (4, 4, 'Bo', 'Portuguese Water Dog', 35, 4, 10, 'Much president much wow.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (5, 5, 'Kissy', 'Toy Fox Terrier', 15, 8, 6, 'Lick lick lick lick lick.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (6, 6, 'Andy', 'Fox Terrier', 18, 7, 3, 'I\'m a cool dog.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (7, 7, 'Daisy', 'Labrador Retriever', 60, 6, 6, 'I\'m not a wolf, but I could be.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (8, 8, 'Daddy', 'American Pit Bull Terrier', 49, 3, 16, 'I\'m very well behaved.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (9, 9, 'Snoop', 'Staffordshire Bull Terrier', 70, 5, 4, 'I was an unlucky dog, now I\'m lucky though', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (10, 10, 'Oprah', 'Schnauzer', 4, 7, 10, 'Apparently 50 cent doesn\'t love mrs. winfrey.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (11, 11, 'Poppy Raymond', 'Goldendoodle', 40, 6, 8, 'Yeah!', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (12, 12, 'Vincent the Dog', 'Black Lab', 65, 7, 6, 'I\'m a wiz for a dog. Or dog for a wiz??', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (13, 3, 'Zsa Zsa', 'English Bulldog', 35, 3, 9, 'I may be ugly but I\'ve got a heart of gold.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (14, 3, 'Martha', 'Neopolitan Mastiff', 125, 4, 6, 'ppphbbbbllllllltttttttt', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (15, 3, 'SweePee Rambo', 'Chinese Crested Chihuahua', 5, 8, 17, 'Ewwwwwwwwwww.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (16, 3, 'Quasi Modo', 'Pit Bull/Dutch Shepherd', 50, 5, 10, 'I kinda look like a chupacabra.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (17, 13, 'Bobo', 'Great Dane', 160, 4, 5, 'Not quite as fast as master.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (18, 14, 'Bella', 'Shorkie (Shitzu/Yorkie)', 4, 6, 4, 'I hold it down at SD.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (19, 15, 'Adobo', 'Jindo', 20, 5, 5, 'I\'m a dj. And also a dog.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (20, 16, 'Nugget', 'Border Terrier', 13, 6, 5, 'I\'m a dog, Harry!', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (21, 21, 'Fido', 'Mutt', 43, 4, 8, 'I was once the FDOTUS, though I never lived in the White House. Looking for love.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (22, 18, 'London', 'Yorkshire Terrier', 4, 5, 11, 'I\'m a dog, and I\'m addicted to you but I\'m not toxic.', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (23, 17, 'Brutus', 'French Bulldog', 8, 4, 1, 'I\'m cute and dangerous.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (24, 19, 'Snuffles', 'Bloodhound', 56, 3, 5, 'I\'m pretty lazy and low energy, but I have the best sense of smell, I\'ll be able to pick you the best dead animal to roll around in!', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (25, 20, 'Comrad', 'Mutt', 12, 7, 3, 'Seize the means of production, dograde. We shall all enjoy the products of our labors. Redistribute the kibble!', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (26, 22, 'Charlie', 'Welsh Terrier', 20, 7, 2, 'Ask not what your dog can do for you, but what you can do for your dog!!!!', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (27, 23, 'Jack', 'Teddy Roosevelt Terrier', 22, 8, 5, '“It is hard to fail, but it is worse never to have tried to sit and stay.”', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (28, 24, 'Fala', 'Scottish Terrier', 19, 9, 6, '\"The only thing we have to fear is- look a squirrel!\"', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (29, 25, 'Buddy', 'Labrador Retriever', 70, 5, 4, '\"I\'m with her. Or really anybody with belly rubs and treats.\"', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (30, 26, 'Sailor Boy', 'Chesapeake Bay Retriever', 72, 6, 4, '\"Great inds discuss ideas; average minds discuss events; small minds discuss people. Dogs discuss squirrels.\"', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (31, 27, 'Willow', 'Corgi', 23, 4, 5, '\"I am Queen Willow of Windsor\"', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (32, 28, 'Fang', 'Black Lab', 75, 6, 8, '\"I\'m actually very gentle and easygoing, despite the name\"', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (33, 29, 'Tinkerbell', 'Chihuahua', 5, 4, 14, '\"I am a princess. I expect to be pampered and you better have A/C.\"', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (34, 30, 'Barbie', 'Beagle', 22, 4, 9, '\"I was rescued from being a lab dog. Can you rescue me from being single?\"', 1, 'Female');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (35, 31, 'Berkly', 'Mutt', 52, 6, 7, 'I am a good boi, a very very good boi.', 1, 'Male');
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`, `sex`) VALUES (36, 32, 'Pipitty Jackson', 'Terrier', 19, 7, 4, 'All I want for Christmas is a bone.', 1, 'Female');

COMMIT;


-- -----------------------------------------------------
-- Data for table `photo`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (1, 1, 'https://bit.ly/2VbWC6k');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (2, 2, 'http://www.letushaveadog.com/wp-content/uploads/2015/08/Taco-Bell-Dog.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (3, 3, 'http://mickeyfix.com/wp-content/uploads/2013/05/The-Big-Bowwowski-500x333.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (4, 4, 'https://abcnews.go.com/images/Politics/ht_bo_obama_dog_jef_111224_wblog.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (5, 5, 'https://celebritypets.net/wp-content/uploads/2017/01/Sarah-Jessica-Parker-Kissy-300x190.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (6, 6, 'https://www.nylabone.com/-/media/images/nylabone-na/us/dog101/breeds-a-z/wire-fox-terrier-jpg.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (7, 7, 'https://i.pinimg.com/originals/89/86/91/898691959db1f399921486473a608341.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (8, 8, 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b5/Daddy_Cesar_Millan_pit_bull.jpg/220px-Daddy_Cesar_Millan_pit_bull.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (9, 9, 'https://i2-prod.mirror.co.uk/incoming/article13773817.ece/ALTERNATES/s615b/1_dumping-dog6.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (10, 10, 'https://vetstreet-brightspot.s3.amazonaws.com/c8/fb/ec5a2313447cac9886e8c7452d85/50%20cent.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (11, 11, 'http://townsquare.media/site/625/files/2015/06/Usher-dog.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (12, 12, 'https://celebritypets.net/wp-content/uploads/2017/03/Wiz-Khalifa-french-bulldog-Vincent.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (13, 2, 'https://www.science20.com/files/images/yo_quiero_taco_bell.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (14, 2, 'https://logo.cafepress.com/4/507270.273574.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (15, 2, 'http://www.obeythepurebreed.com/images/chihuahua_che_large.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (16, 4, 'https://static.politico.com/d5/80/165a405f4b4ea16a9ba6acc09b21/151009-bo-obama-gallery-ball-air-force-one-gty-1160.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (17, 3, 'https://3milliondogs.com/blog-assets-two/2016/08/Lady.png');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (18, 5, 'https://i.dailymail.co.uk/i/pix/2011/02/21/article-1359315-0D4C951F000005DC-110_468x608.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (19, 6, 'https://schulzmuseum.org/wp-content/uploads/2012/03/SparkyAndy-02.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (20, 7, 'https://i.pinimg.com/originals/5c/0b/7b/5c0b7b2225c863b832ec80f059e77785.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (21, 7, 'http://taildom.com/blog/wp-content/uploads/2010/10/kevin-costner-dog-daisy-and-jan.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (22, 7, 'https://www.tribute.ca/news/wp-content/uploads/2010/08/orange_dog.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (23, 8, 'https://straightfromthedogsmouth.files.wordpress.com/2011/08/dogdaddy-3.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (24, 8, 'https://alchetron.com/cdn/daddy-dog-0548af99-c741-4a6d-9a70-e8a96a5c907-resize-750.jpeg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (25, 13, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc4oARP_X5LUlaSEWoTsNRGvt49nNvgXBWCz31ACSaJYhd3o4rpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (26, 13, 'https://bringmethenews.com/.image/t_share/MTU2NTQxMjIwNDg5ODY0Mjgz/screen-shot-2018-06-24-at-81658-am.png');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (27, 13, 'http://newsmobile.in/wp-content/uploads/2018/06/DgcGb0hVQAEBc0k.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (28, 14, 'https://media4.s-nbcnews.com/j/MSNBC/Components/Video/201706/tdy_pets_worlds_ugliest_dog_170626.760;428;7;70;5.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (29, 14, 'https://media.npr.org/assets/img/2017/06/24/gettyimages-800244140_wide-56b2dddbeaab2aa5f921a9c847aad42ce5bec021-s800-c85.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (30, 14, 'https://toofab.akamaized.net/2017/06/24/ugly-dog-810x610.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (31, 15, 'http://www.wrongur.com/img/polls/poll-473.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (32, 15, 'https://www.abc.net.au/news/image/9904112-3x2-940x627.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (33, 15, 'https://www.usmagazine.com/wp-content/uploads/sweepee-ugliest-dog-2-daa14eca-0dcd-45c7-999c-b959f71288d3.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (34, 16, 'https://lovelace-media.imgix.net/getty/450965060.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (35, 16, 'https://www.trbimg.com/img-55bbbb69/turbine/sfl-quasi-modo-the-world-s-ugliest-dog-20150729');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (36, 16, 'https://bit.ly/2BMJkWl');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (37, 1, 'https://bit.ly/2EmxqUN');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (38, 1, 'https://bit.ly/2EosG16');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (39, 17, 'https://pbs.twimg.com/media/CRx46fvUEAA75_1.jpg:large');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (40, 19, 'https://pbs.twimg.com/media/DXfHr9ZWAAYdDO6.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (41, 18, 'https://bit.ly/2BPbTCO');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (42, 18, 'https://photos.google.com/photo/AF1QipPsP4p6klhmHvjkD3e10TnskvhYVwlYIpo17bDR');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (43, 19, 'https://www.petguide.com/wp-content/uploads/2016/02/korean-jindo.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (44, 20, 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12235916/Border-Terrier-On-White-03.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (45, 20, 'https://bit.ly/2GWGjpR');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (46, 21, 'https://americacomesalive.com/i/Fido-Lincolns-dog-300x2071.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (47, 23, 'https://usatftw.files.wordpress.com/2015/09/dog.jpg?w=1000&h=600&crop=1');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (48, 23, 'http://www.pethealthnetwork.com/sites/default/files/articles/prev_dwayne-the-rock-johnson-saves-french-bulldog-from-drowning536724871.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (49, 22, 'http://i.dlisted.com/files/87890399.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (50, 22, 'http://i.dlisted.com/files/londonisalivetoday.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (51, 24, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Bloodhound_2.jpg/220px-Bloodhound_2.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (52, 24, 'https://c8.alamy.com/comp/GNN22E/red-bloodhound-GNN22E.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (53, 25, 'https://pbs.twimg.com/profile_images/912177731923841024/7xnw5QTo_400x400.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (54, 25, 'https://steamuserimages-a.akamaihd.net/ugc/357276631075251978/FB7BFBF2889B3471A29FFD2F399262E474205428/');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (55, 26, 'https://americacomesalive.com/i/Charlie-and-turkey.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (56, 26, 'https://americacomesalive.com/i/charlie-and-jfk-color.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (57, 27, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Teddyterrier.jpg/220px-Teddyterrier.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (58, 27, 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12190123/Teddy-Roosevelt-Terrier-History-03.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (59, 28, 'https://images.findagrave.com/photos250/photos/2004/187/6649130_108913209798.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (60, 28, 'https://schoolvisitexperts.com/wp-content/uploads/2010/12/FAla-Roosevelt-in-Car-300x152.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (61, 29, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Buddy_Clinton_dog.jpg/220px-Buddy_Clinton_dog.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (62, 29, 'https://bit.ly/2SefAas');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (63, 30, 'https://bit.ly/2GBYkKR');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (64, 30, 'https://vetstreet-brightspot.s3.amazonaws.com/89/b629409e9411e0a2380050568d634f/file/Chesapeake-Bay-Retriever-3-645mk062111.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (65, 31, 'https://www.petguide.com/wp-content/uploads/2018/04/queen-corgi-willow.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (66, 31, 'https://sa.kapamilya.com/absnews/abscbnnews/media/2018/news/04/19/willow-041918.jpg?ext=.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (67, 32, 'https://ybxzcgnc7b-flywheel.netdna-ssl.com/wp-content/uploads/2017/04/black-labs-loving-dogs.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (68, 32, 'https://brooklinelabrescue.org/dev/wp-content/uploads/2018/08/2-Year-Old-Black-Lab-Maggie-e1535230869182.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (69, 33, 'http://www.famouschihuahua.com/wp-content/uploads/2011/10/tinkerbell-chihuahua.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (70, 33, 'http://www.famouschihuahua.com/wp-content/uploads/2008/12/tinkerbell-the-chihuahua.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (71, 34, 'https://peopledotcom.files.wordpress.com/2017/08/barbie-1.jpg?w=768');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (72, 34, 'https://peopledotcom.files.wordpress.com/2017/08/barbie-1.jpg?w=768');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (73, 35, 'https://i.pinimg.com/236x/a4/53/58/a4535825c8b5c088693d1ec61f7a616b--boys-mix.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (74, 35, 'https://i.imgur.com/YzFGhZc.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (75, 36, 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/43730444/1/?bust=1547058914&width=720');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (76, 36, 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Jack_Russell_Terrier_1.jpg/220px-Jack_Russell_Terrier_1.jpg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (77, 1, 'https://bit.ly/2GUn54h');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (78, 1, 'https://bit.ly/2EoXHCg');
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (79, 1, 'https://bit.ly/2txNg8U');

COMMIT;


-- -----------------------------------------------------
-- Data for table `likes`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (1, 1, 2);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (2, 3, 2);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (3, 2, 3);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (4, 5, 6);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (5, 6, 5);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (6, 3, 8);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (7, 8, 3);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (8, 2, 5);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (9, 9, 2);
INSERT INTO `likes` (`id`, `this_dog`, `that_dog`) VALUES (10, 2, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dislike`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (1, 1, 4);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (2, 2, 4);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (3, 5, 11);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (4, 5, 12);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (5, 6, 11);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (6, 6, 12);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (7, 8, 2);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (8, 8, 5);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (9, 8, 6);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (10, 2, 11);
INSERT INTO `dislike` (`id`, `this_dog`, `that_dog`) VALUES (11, 11, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `matches`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `matches` (`id`, `dog1_id`, `dog2_id`) VALUES (1, 2, 3);
INSERT INTO `matches` (`id`, `dog1_id`, `dog2_id`) VALUES (2, 5, 6);
INSERT INTO `matches` (`id`, `dog1_id`, `dog2_id`) VALUES (3, 3, 8);
INSERT INTO `matches` (`id`, `dog1_id`, `dog2_id`) VALUES (4, 2, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `preferences`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (1, 1, 0, 200, 1, 10, 0, 30, 'Male');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (2, 2, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (3, 3, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (4, 4, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (5, 5, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (6, 6, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (7, 7, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (8, 8, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (9, 9, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (10, 10, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (11, 11, 0, 500, 1, 10, 0, 30, 'Any');
INSERT INTO `preferences` (`id`, `dog_id`, `min_weight`, `max_weight`, `min_energy`, `max_energy`, `min_age`, `max_age`, `sex`) VALUES (12, 12, 0, 500, 1, 10, 0, 30, 'Any');

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (1, 2, 3, 'Hi little dude!', '2019-02-11 15:02:55', 1);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (2, 3, 2, 'Woof!', '2019-02-11 15:12:13', 0);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (3, 5, 6, 'Woof! Woof! Ruff! Aroo!', '2019-02-13 09:02:55', 0);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (4, 6, 5, ';)', '2019-02-13 10:12:01', 0);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (5, 5, 6, 'Ruffarooooo!!!', '2019-02-13 10:43:20', 0);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (6, 6, 5, '????', '2019-02-13 11:01:02', 0);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (7, 5, 6, '!!!!!!', '2019-02-11 13:02:55', 0);
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`, `opened`) VALUES (8, 3, 8, 'Oh hi am dog you are cute', '2019-02-14 19:19:05', 0);

COMMIT;

