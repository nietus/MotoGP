-- Set up environment
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Create schema
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- Create Time table
CREATE TABLE IF NOT EXISTS `Time` (
  `Nome` VARCHAR(20) NOT NULL,
  `Pais` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC) VISIBLE,
  PRIMARY KEY (`Nome`)
) ENGINE = InnoDB;

-- Create Piloto table
CREATE TABLE IF NOT EXISTS `Piloto` (
  `idPiloto` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(20) NOT NULL,
  `Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idPiloto`),
  UNIQUE INDEX `idPiloto_UNIQUE` (`idPiloto` ASC) VISIBLE,
  INDEX `fk_Piloto_Time1_idx` (`Time_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Piloto_Time1`
    FOREIGN KEY (`Time_Nome`)
    REFERENCES `Time` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create Mecanico table
CREATE TABLE IF NOT EXISTS `Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `Especialidade` VARCHAR(20) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idMecanico`),
  INDEX `fk_Mecanico_Time1_idx` (`Time_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Time1`
    FOREIGN KEY (`Time_Nome`)
    REFERENCES `Time` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create Circuito table
CREATE TABLE IF NOT EXISTS `Circuito` (
  `idCircuito` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(20) NOT NULL,
  `Comprimento` FLOAT NOT NULL,
  UNIQUE INDEX `idCircuito_UNIQUE` (`idCircuito` ASC) VISIBLE,
  PRIMARY KEY (`idCircuito`)
) ENGINE = InnoDB;

-- Create Corrida table
CREATE TABLE IF NOT EXISTS `Corrida` (
  `idCorrida` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NULL,
  `Circuito_idCircuito` INT NOT NULL,
  PRIMARY KEY (`idCorrida`),
  UNIQUE INDEX `idCorrida_UNIQUE` (`idCorrida` ASC) VISIBLE,
  INDEX `fk_Corrida_Circuito1_idx` (`Circuito_idCircuito` ASC) VISIBLE,
  CONSTRAINT `fk_Corrida_Circuito1`
    FOREIGN KEY (`Circuito_idCircuito`)
    REFERENCES `Circuito` (`idCircuito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create Temporada table
CREATE TABLE IF NOT EXISTS `Temporada` (
  `Ano` YEAR(4) NOT NULL,
  PRIMARY KEY (`Ano`),
  UNIQUE INDEX `Ano_UNIQUE` (`Ano` ASC) VISIBLE
) ENGINE = InnoDB;

-- Create Classificacao table
CREATE TABLE IF NOT EXISTS `Classificacao` (
  `Pontos` INT NOT NULL,
  `Piloto_idPiloto` INT NOT NULL,
  `Temporada_Ano` YEAR(4) NOT NULL,
  `Corrida_idCorrida` INT NOT NULL,
  PRIMARY KEY (`Piloto_idPiloto`, `Temporada_Ano`, `Corrida_idCorrida`),
  INDEX `fk_Classificacao_Temporada1_idx` (`Temporada_Ano` ASC) VISIBLE,
  INDEX `fk_Classificacao_Corrida1_idx` (`Corrida_idCorrida` ASC) VISIBLE,
  CONSTRAINT `fk_Classificacao_Piloto1`
    FOREIGN KEY (`Piloto_idPiloto`)
    REFERENCES `Piloto` (`idPiloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Classificacao_Temporada1`
    FOREIGN KEY (`Temporada_Ano`)
    REFERENCES `Temporada` (`Ano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Classificacao_Corrida1`
    FOREIGN KEY (`Corrida_idCorrida`)
    REFERENCES `Corrida` (`idCorrida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create AppUser table
CREATE TABLE IF NOT EXISTS `AppUser` (
  `Usuario` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Email`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE
) ENGINE = InnoDB;

-- Create Favorito table
CREATE TABLE IF NOT EXISTS `Favorito` (
  `AppUser_Email` VARCHAR(45) NOT NULL,
  `Piloto_idPiloto` INT NOT NULL,
  `Piloto_Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`AppUser_Email`, `Piloto_idPiloto`, `Piloto_Time_Nome`),
  INDEX `fk_AppUser_has_Piloto_Piloto1_idx` (`Piloto_idPiloto` ASC, `Piloto_Time_Nome` ASC) VISIBLE,
  INDEX `fk_AppUser_has_Piloto_AppUser1_idx` (`AppUser_Email` ASC) VISIBLE,
  CONSTRAINT `fk_AppUser_has_Piloto_AppUser1`
    FOREIGN KEY (`AppUser_Email`)
    REFERENCES `AppUser` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppUser_has_Piloto_Piloto1`
    FOREIGN KEY (`Piloto_idPiloto`)
    REFERENCES `Piloto` (`idPiloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create Comentario table
CREATE TABLE IF NOT EXISTS `Comentario` (
  `AppUser_Email` VARCHAR(45) NOT NULL,
  `Texto` VARCHAR(300) NULL,
  `Corrida_idCorrida` INT NOT NULL,
  PRIMARY KEY (`AppUser_Email`, `Corrida_idCorrida`),
  INDEX `fk_AppUser_has_Corrida_AppUser1_idx` (`AppUser_Email` ASC) VISIBLE,
  INDEX `fk_Comentario_Corrida1_idx` (`Corrida_idCorrida` ASC) VISIBLE,
  CONSTRAINT `fk_AppUser_has_Corrida_AppUser1`
    FOREIGN KEY (`AppUser_Email`)
    REFERENCES `AppUser` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Corrida1`
    FOREIGN KEY (`Corrida_idCorrida`)
    REFERENCES `Corrida` (`idCorrida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create Patrocinador table
CREATE TABLE IF NOT EXISTS `Patrocinador` (
  `Nome` CHAR(20) NOT NULL,
  `Pais` CHAR(20) NULL,
  PRIMARY KEY (`Nome`)
) ENGINE = InnoDB;

-- Create Patrocinio table
CREATE TABLE IF NOT EXISTS `Patrocinio` (
  `Patrocinador_Nome` CHAR(20) NOT NULL,
  `Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Patrocinador_Nome`, `Time_Nome`),
  INDEX `fk_Patrocinador_has_Time_Time1_idx` (`Time_Nome` ASC) VISIBLE,
  INDEX `fk_Patrocinador_has_Time_Patrocinador1_idx` (`Patrocinador_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Patrocinador_has_Time_Patrocinador1`
    FOREIGN KEY (`Patrocinador_Nome`)
    REFERENCES `Patrocinador` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patrocinador_has_Time_Time1`
    FOREIGN KEY (`Time_Nome`)
    REFERENCES `Time` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Reset environment
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
