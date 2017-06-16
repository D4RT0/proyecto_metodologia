-- MySQL Script generated by MySQL Workbench
-- mar 13 jun 2017 23:06:42 CLT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema proyecto_metodologia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `proyecto_metodologia` ;

-- -----------------------------------------------------
-- Schema proyecto_metodologia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_metodologia` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_metodologia` ;

-- -----------------------------------------------------
-- Table `proyecto_metodologia`.`bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_metodologia`.`bus` ;

CREATE TABLE IF NOT EXISTS `proyecto_metodologia`.`bus` (
  `id_bus` VARCHAR(30) NOT NULL,
  `bodega` VARCHAR(45) NULL,
  `estado` INT(1) NULL,
  PRIMARY KEY (`id_bus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_metodologia`.`viaje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_metodologia`.`viaje` ;

CREATE TABLE IF NOT EXISTS `proyecto_metodologia`.`viaje` (
  `id_viaje` INT NOT NULL AUTO_INCREMENT,
  `hora_inicio` TIME NULL,
  `hora_destino` TIME NULL,
  `estado` INT(1) NULL,
  `punto_inicio` VARCHAR(45) NULL,
  `punto_destino` VARCHAR(45) NULL,
  `dia` INT(2) NOT NULL,
  PRIMARY KEY (`id_viaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_metodologia`.`chofer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_metodologia`.`chofer` ;

CREATE TABLE IF NOT EXISTS `proyecto_metodologia`.`chofer` (
  `id_chofer` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `edad` INT(2) NULL,
  `telefono` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  `ubicacion` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `estado` INT(1) NULL,
  PRIMARY KEY (`id_chofer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_metodologia`.`administrador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_metodologia`.`administrador` ;

CREATE TABLE IF NOT EXISTS `proyecto_metodologia`.`administrador` (
  `run` VARCHAR(12) NOT NULL,
  `password` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `edad` INT(2) NULL,
  `telefono` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  PRIMARY KEY (`run`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_metodologia`.`turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_metodologia`.`turno` ;

CREATE TABLE IF NOT EXISTS `proyecto_metodologia`.`turno` (
  `id_turno` INT NOT NULL,
  `inicio_descanso` TIME NULL,
  `termino_descanso` TIME NULL,
  `fecha_turno` TIMESTAMP NULL,
  `viaje_id_viaje` INT NOT NULL,
  `bus_id_bus` VARCHAR(30) NOT NULL,
  `chofer_id_chofer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_turno`, `viaje_id_viaje`, `bus_id_bus`, `chofer_id_chofer`),
  INDEX `fk_turno_viaje_idx` (`viaje_id_viaje` ASC),
  INDEX `fk_turno_bus1_idx` (`bus_id_bus` ASC),
  INDEX `fk_turno_chofer1_idx` (`chofer_id_chofer` ASC),
  CONSTRAINT `fk_turno_viaje`
    FOREIGN KEY (`viaje_id_viaje`)
    REFERENCES `proyecto_metodologia`.`viaje` (`id_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turno_bus1`
    FOREIGN KEY (`bus_id_bus`)
    REFERENCES `proyecto_metodologia`.`bus` (`id_bus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turno_chofer1`
    FOREIGN KEY (`chofer_id_chofer`)
    REFERENCES `proyecto_metodologia`.`chofer` (`id_chofer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_metodologia`.`solicitud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_metodologia`.`solicitud` ;

CREATE TABLE IF NOT EXISTS `proyecto_metodologia`.`solicitud` (
  `idsolicitud` INT NOT NULL,
  `tipo_solicitud` INT(1) NULL,
  `estado` INT(1) NULL,
  `observacion` VARCHAR(45) NULL,
  `fecha_inicio` TIMESTAMP NULL,
  `fecha_final` TIMESTAMP NULL,
  `administrador_run` VARCHAR(12) NOT NULL,
  `turno_id_turno` INT NOT NULL,
  `turno_viaje_id_viaje` INT NOT NULL,
  `turno_bus_id_bus` VARCHAR(30) NOT NULL,
  `turno_chofer_id_chofer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsolicitud`, `administrador_run`, `turno_id_turno`, `turno_viaje_id_viaje`, `turno_bus_id_bus`, `turno_chofer_id_chofer`),
  INDEX `fk_solicitud_administrador1_idx` (`administrador_run` ASC),
  INDEX `fk_solicitud_turno1_idx` (`turno_id_turno` ASC, `turno_viaje_id_viaje` ASC, `turno_bus_id_bus` ASC, `turno_chofer_id_chofer` ASC),
  CONSTRAINT `fk_solicitud_administrador1`
    FOREIGN KEY (`administrador_run`)
    REFERENCES `proyecto_metodologia`.`administrador` (`run`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitud_turno1`
    FOREIGN KEY (`turno_id_turno` , `turno_viaje_id_viaje` , `turno_bus_id_bus` , `turno_chofer_id_chofer`)
    REFERENCES `proyecto_metodologia`.`turno` (`id_turno` , `viaje_id_viaje` , `bus_id_bus` , `chofer_id_chofer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
