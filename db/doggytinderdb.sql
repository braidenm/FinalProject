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
  `active` TINYINT NOT NULL DEFAULT 1,
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
  `time_sent` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (1, 'admin', 'password', 'admin', 'admin@admin.com', 1, 0, 'Administrius', 'Diggy', 'Male', 1, 40, 'https://cdn3.iconfinder.com/data/icons/gray-user-toolbar/512/oficcial-512.png');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (2, 'doglover', 'ilikedogs', 'standard', 'doglover@paws.com', 1, 0, 'Joan', 'Bayez', 'Female', 2, 78, 'https://d279m997dpfwgl.cloudfront.net/wp/2018/09/0910_baez-1000x743.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (3, 'thedogabides', 'lovedogs', 'standard', 'thedogabides@dude.com', 1, 0, 'Jeff \"The Dude\"', 'Lebowski', 'Male', 3, 65, 'https://uproxx.files.wordpress.com/2019/02/the-dude-the-big-lebowski.jpg?w=300&h=210&crop=1&quality=100');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (4, 'number44', 'michelle', 'standard', '44@whitehouse.gov', 1, 0, 'Barack', 'Obama', 'Male', 4, 57, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE4MDAzNDEwNzg5ODI4MTEw/barack-obama-12782369-1-402.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (5, 'doggonecrazy', 'lovedogs', 'standard', 'crazyfordogs@dog.com', 1, 0, 'Sarah', 'Parker', 'Female', 5, 52, 'https://timedotcom.files.wordpress.com/2014/11/sarah-jessica-parker.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (6, 'puppermintpatty', 'lovedogs', 'standard', 'puppermintpatty@dog.com', 1, 0, 'Patty', 'Peppermint', 'Female', 6, 39, 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a0/Peppermint_Patty.png/170px-Peppermint_Patty.png');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (7, 'danceswithdogs', 'ilikedogs', 'standard', 'runswithdogs@dog.com', 1, 0, 'Kevin', 'Costner', 'Male', 7, 64, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NDg0MDU0OTMzNTA1NTUx/kevin-costner-9258776-1-402.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (8, 'thedogwhisperer', 'whisper', 'standard', 'dogwhisperer@dog.com', 1, 0, 'Cesar', 'Millan', 'Male', 8, 49, 'https://pbs.twimg.com/profile_images/1028109745356304384/QAttxEQ1_400x400.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (9, 'snoopdogg', 'fosheezy', 'standard', 'snoopdiggitydogg@dwestcoast.com', 1, 0, 'Snoop', 'Dogg', 'Male', 9, 47, 'https://pbs.twimg.com/profile_images/943933166015803392/jvjasD7v_400x400.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (10, '50cent', 'indaclub', 'standard', '50cent@gunit.com', 1, 0, 'Curtis', 'Jackson', 'Male', 10, 43, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NDg0MDU1NDExNDU5NTk5/after-earth-new-york-premiere---inside-arrivals.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (11, 'usher', 'yeah', 'standard', 'usher@sings.com', 1, 0, 'Usher', 'Raymond', 'Male', 11, 40, 'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTIwNjA4NjMzNDczNzYyODI4/95-106-capital-fm-summertime-ball-2012---media-run.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `role`, `email`, `active`, `banned`, `first_name`, `last_name`, `gender`, `address_id`, `age`, `url`) VALUES (12, 'wizkid', 'ilikedogs', 'standard', 'wizkid@music.com', 1, 0, 'Wiz', 'Khalifa', 'Male', 12, 31, 'https://www.billboard.com/files/media/Wiz-Khalifa-vanity-fair-2018-billboard-1548.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `dog`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (1, 1, 'Spot', 'Mutt', 50, 5, 3, 'I am spot, see me run.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (2, 2, 'The Revolution', 'Chihuahua', 4, 8, 7, 'Yip! Yip!', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (3, 3, 'Little Dude', 'Bulldog', 45, 2, 4, 'I abide.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (4, 4, 'Bo', 'Portuguese Water Dog', 35, 4, 10, 'Much president much wow.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (5, 5, 'Kissy', 'Toy Fox Terrier', 15, 8, 6, 'Lick lick lick lick lick.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (6, 6, 'Andy', 'Fox Terrier', 18, 7, 3, 'I\'m a cool dog.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (7, 7, 'Daisy', 'Labrador Retriever', 60, 6, 6, 'I\'m not a wolf, but I could be.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (8, 8, 'Daddy', 'American Pit Bull Terrier', 49, 3, 16, 'I\'m very well behaved.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (9, 9, 'Snoop', 'Staffordshire Bull Terrier', 70, 5, 4, 'I was an unlucky dog, now I\'m lucky though', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (10, 10, 'Oprah', 'Schnauzer', 4, 7, 10, 'Apparently 50 cent doesn\'t love mrs. winfrey.', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (11, 11, 'Poppy Raymond', 'Goldendoodle', 40, 6, 8, 'Yeah!', 1);
INSERT INTO `dog` (`id`, `user_id`, `name`, `breed`, `weight`, `energy`, `age`, `about`, `active`) VALUES (12, 12, 'Vincent the Dog', 'Black Lab', 65, 7, 6, 'I\'m a wiz for a dog. Or dog for a wiz??', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `photo`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `photo` (`id`, `dog_id`, `url`) VALUES (1, 1, 'https://data.junkee.com/wp-content/uploads/2014/06/Spot.jpg');
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `like`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (1, 2);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (3, 2);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (2, 3);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (5, 6);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (6, 5);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (3, 8);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (8, 3);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (2, 5);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (9, 2);
INSERT INTO `like` (`this_dog`, `that_dog`) VALUES (2, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dislike`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (1, 4);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (2, 4);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (5, 11);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (5, 12);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (6, 11);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (6, 12);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (8, 2);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (8, 5);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (8, 6);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (2, 11);
INSERT INTO `dislike` (`this_dog`, `that_dog`) VALUES (11, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `match`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `match` (`dog1_id`, `dog2_id`) VALUES (2, 3);
INSERT INTO `match` (`dog1_id`, `dog2_id`) VALUES (5, 6);
INSERT INTO `match` (`dog1_id`, `dog2_id`) VALUES (3, 8);
INSERT INTO `match` (`dog1_id`, `dog2_id`) VALUES (2, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `doggytinderdb`;
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (1, 2, 3, 'Hi little dude!', '2019-02-11 15:02:55');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (2, 3, 2, 'Woof!', '2019-02-11 15:12:13');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (3, 5, 6, 'Woof! Woof! Ruff! Aroo!', '2019-02-13 09:02:55');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (4, 6, 5, ';)', '2019-02-13 10:12:01');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (5, 5, 6, 'Ruffarooooo!!!', '2019-02-13 10:43:20');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (6, 6, 5, '????', '2019-02-13 11:01:02');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (7, 5, 6, '!!!!!!', '2019-02-11 13:02:55');
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `text`, `time_sent`) VALUES (8, 3, 8, 'Oh hi am dog you are cute', '2019-02-14 19:19:05');

COMMIT;

