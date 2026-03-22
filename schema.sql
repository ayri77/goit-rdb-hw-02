-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema orders_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema orders_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `orders_db` DEFAULT CHARACTER SET utf8 ;
USE `orders_db` ;

-- -----------------------------------------------------
-- Table `orders_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders_db`.`customers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders_db`.`orders` (
  `id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `customer_id` INT NOT NULL,
  INDEX `orders-clients_idx` (`customer_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `orders-customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `orders_db`.`customers` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders_db`.`SKU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders_db`.`SKU` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders_db`.`order_SKU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders_db`.`order_SKU` (
  `order_id` INT NOT NULL,
  `SKU_id` INT NOT NULL,
  `qty` INT NOT NULL,
  INDEX `content-SKU_idx` (`SKU_id` ASC) VISIBLE,
  PRIMARY KEY (`SKU_id`, `order_id`),
  INDEX `orders-order_SKU_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_SKU-order_SKU`
    FOREIGN KEY (`SKU_id`)
    REFERENCES `orders_db`.`SKU` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders-order_SKU`
    FOREIGN KEY (`order_id`)
    REFERENCES `orders_db`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
