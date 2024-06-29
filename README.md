## MotoGP DB (Minimundo)

O MotoGP é a principal categoria do Campeonato Mundial de Motovelocidade, reunindo as melhores equipes, pilotos e mecânicos em uma competição emocionante em circuitos de todo o mundo. As equipes, como Yamaha, Honda e Ducati, buscam aperfeiçoar suas máquinas e estratégias para alcançar a vitória nas corridas, realizadas em circuitos renomados como o Circuito de Jerez, em Espanha, e o Circuito das Américas, nos Estados Unidos. Os pilotos, estrelas como Valentino Rossi, Marc Márquez e Jorge Lorenzo, enfrentam desafios únicos em cada corrida, buscando conquistar pontos para alcançar a liderança na classificação geral. Os mecânicos das equipes desempenham um papel crucial, ajustando as motos para garantir o melhor desempenho em cada pista. Os patrocinadores, como a Red Bull e a Monster Energy, apoiam as equipes e contribuem para o espetáculo emocionante do MotoGP. Os fãs de todo o mundo acompanham de perto cada corrida, criando uma comunidade global de entusiastas do motociclismo.

* **Equipe:** Representa as equipes participantes do MotoGP, como Yamaha, Honda, Ducati, etc. Cada equipe possui um nome, país de origem e pode ter vários pilotos e mecânicos associados.
* **Piloto:** Representa os pilotos que competem no MotoGP. Cada piloto tem um nome, país de origem, equipe atual e pode ter participado de várias corridas em diferentes temporadas.
* **Mecanico:** Representa os mecânicos que trabalham para uma equipe no MotoGP. Cada mecânico tem um nome, especialidade (por exemplo, motor, suspensão, eletrônica) e pode pertencer a apenas uma equipe.
* **Circuito:** Representa os circuitos onde as corridas do MotoGP são realizadas. Cada circuito tem um nome, país, comprimento da pista e pode hospedar várias corridas em diferentes temporadas.
* **Corrida:** Representa as corridas individuais do MotoGP realizadas em um circuito específico em uma determinada temporada. Cada corrida tem uma data, localização (circuito), vencedor e classificação de todos os pilotos.
* **Temporada:** Representa uma temporada completa do MotoGP, que inclui várias corridas realizadas em diferentes circuitos ao longo de um ano. Cada temporada tem um ano, várias corridas e uma classificação final dos pilotos e equipes.
* **Classificação:** Representa a classificação final dos pilotos e equipes em uma temporada específica do MotoGP. A classificação inclui a posição final, pontos acumulados e outras estatísticas relevantes.
* **AppUser:** Representa os usuários do sistema, que podem ser fãs, jornalistas ou qualquer pessoa interessada no MotoGP. Os usuários podem criar listas de favoritos e comentar resultados de corridas.
* **Patrocinador:** Representa os patrocinadores envolvidos no MotoGP. Cada patrocinador tem um nome, país de origem e pode patrocinar uma ou mais equipes.

### Diagrama Conceitual

![P](conceitual.png)


### Diagrama Esquema

![P](esquema.png)


### Pé de galinha

![P](pe.png)

### Scripts SQL

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- Schema mydb


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;


-- Table `mydb`.`Time`


CREATE TABLE IF NOT EXISTS `mydb`.`Time` (
  `Nome` VARCHAR(20) NOT NULL,
  `Pais` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC) VISIBLE,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- Table `mydb`.`Piloto`


CREATE TABLE IF NOT EXISTS `mydb`.`Piloto` (
  `idPiloto` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(20) NOT NULL,
  `Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idPiloto`, `Time_Nome`),
  INDEX `fk_Piloto_Time1_idx` (`Time_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Piloto_Time1`
    FOREIGN KEY (`Time_Nome`)
    REFERENCES `mydb`.`Time` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Table `mydb`.`Mecanico`


CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `Especialidade` VARCHAR(20) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idMecanico`, `Time_Nome`),
  INDEX `fk_Mecanico_Time1_idx` (`Time_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Time1`
    FOREIGN KEY (`Time_Nome`)
    REFERENCES `mydb`.`Time` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Table `mydb`.`Circuito`


CREATE TABLE IF NOT EXISTS `mydb`.`Circuito` (
  `idCircuito` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(20) NOT NULL,
  `Comprimento` FLOAT NOT NULL,
  UNIQUE INDEX `idCircuito_UNIQUE` (`idCircuito` ASC) VISIBLE,
  PRIMARY KEY (`idCircuito`))
ENGINE = InnoDB;


-- Table `mydb`.`Corrida`


CREATE TABLE IF NOT EXISTS `mydb`.`Corrida` (
  `idCorrida` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NULL,
  `Circuito_idCircuito` INT NOT NULL,
  PRIMARY KEY (`idCorrida`, `Circuito_idCircuito`),
  UNIQUE INDEX `idCorrida_UNIQUE` (`idCorrida` ASC) VISIBLE,
  INDEX `fk_Corrida_Circuito1_idx` (`Circuito_idCircuito` ASC) VISIBLE,
  CONSTRAINT `fk_Corrida_Circuito1`
    FOREIGN KEY (`Circuito_idCircuito`)
    REFERENCES `mydb`.`Circuito` (`idCircuito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Table `mydb`.`Temporada`


CREATE TABLE IF NOT EXISTS `mydb`.`Temporada` (
  `Ano` YEAR(4) NOT NULL,
  PRIMARY KEY (`Ano`),
  UNIQUE INDEX `Ano_UNIQUE` (`Ano` ASC) VISIBLE)
ENGINE = InnoDB;


-- Table `mydb`.`Classificacao`


CREATE TABLE IF NOT EXISTS `mydb`.`Classificacao` (
  `Pontos` INT NOT NULL,
  `Piloto_idPiloto` INT NOT NULL,
  `Temporada_Ano` YEAR(4) NOT NULL,
  `Corrida_idCorrida` INT NOT NULL,
  PRIMARY KEY (`Piloto_idPiloto`, `Temporada_Ano`, `Corrida_idCorrida`),
  INDEX `fk_Classificacao_Temporada1_idx` (`Temporada_Ano` ASC) VISIBLE,
  INDEX `fk_Classificacao_Corrida1_idx` (`Corrida_idCorrida` ASC) VISIBLE,
  CONSTRAINT `fk_Classificacao_Piloto1`
    FOREIGN KEY (`Piloto_idPiloto`)
    REFERENCES `mydb`.`Piloto` (`idPiloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Classificacao_Temporada1`
    FOREIGN KEY (`Temporada_Ano`)
    REFERENCES `mydb`.`Temporada` (`Ano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Classificacao_Corrida1`
    FOREIGN KEY (`Corrida_idCorrida`)
    REFERENCES `mydb`.`Corrida` (`idCorrida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Table `mydb`.`AppUser`


CREATE TABLE IF NOT EXISTS `mydb`.`AppUser` (
  `Usuario` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Email`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE);


-- Table `mydb`.`Favorito`


CREATE TABLE IF NOT EXISTS `mydb`.`Favorito` (
  `AppUser_Email` VARCHAR(45) NOT NULL,
  `Piloto_idPiloto` INT NOT NULL,
  `Piloto_Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`AppUser_Email`, `Piloto_idPiloto`, `Piloto_Time_Nome`),
  INDEX `fk_AppUser_has_Piloto_Piloto1_idx` (`Piloto_idPiloto` ASC, `Piloto_Time_Nome` ASC) VISIBLE,
  INDEX `fk_AppUser_has_Piloto_AppUser1_idx` (`AppUser_Email` ASC) VISIBLE,
  CONSTRAINT `fk_AppUser_has_Piloto_AppUser1`
    FOREIGN KEY (`AppUser_Email`)
    REFERENCES `mydb`.`AppUser` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppUser_has_Piloto_Piloto1`
    FOREIGN KEY (`Piloto_idPiloto`)
    REFERENCES `mydb`.`Piloto` (`idPiloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- Table `mydb`.`Comentario`


CREATE TABLE IF NOT EXISTS `mydb`.`Comentario` (
  `AppUser_Email` VARCHAR(45) NOT NULL,
  `Texto` VARCHAR(300) NULL,
  `Corrida_idCorrida` INT NOT NULL,
  PRIMARY KEY (`AppUser_Email`, `Corrida_idCorrida`),
  INDEX `fk_AppUser_has_Corrida_AppUser1_idx` (`AppUser_Email` ASC) VISIBLE,
  INDEX `fk_Comentario_Corrida1_idx` (`Corrida_idCorrida` ASC) VISIBLE,
  CONSTRAINT `fk_AppUser_has_Corrida_AppUser1`
    FOREIGN KEY (`AppUser_Email`)
    REFERENCES `mydb`.`AppUser` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Corrida1`
    FOREIGN KEY (`Corrida_idCorrida`)
    REFERENCES `mydb`.`Corrida` (`idCorrida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- Table `mydb`.`Patrocinador`


CREATE TABLE IF NOT EXISTS `mydb`.`Patrocinador` (
  `Nome` CHAR(20) NOT NULL,
  `Pais` CHAR(20) NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- Table `mydb`.`Patrocinio`


CREATE TABLE IF NOT EXISTS `mydb`.`Patrocinio` (
  `Patrocinador_Nome` CHAR(20) NOT NULL,
  `Time_Nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Patrocinador_Nome`, `Time_Nome`),
  INDEX `fk_Patrocinador_has_Time_Time1_idx` (`Time_Nome` ASC) VISIBLE,
  INDEX `fk_Patrocinador_has_Time_Patrocinador1_idx` (`Patrocinador_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Patrocinador_has_Time_Patrocinador1`
    FOREIGN KEY (`Patrocinador_Nome`)
    REFERENCES `mydb`.`Patrocinador` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patrocinador_has_Time_Time1`
    FOREIGN KEY (`Time_Nome`)
    REFERENCES `mydb`.`Time` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

### População do BD

-- MySQL Script to Populate MotoGP Database with Detailed Information

USE `mydb`;

-- Populate Time
INSERT INTO `Time` (`Nome`, `Pais`) VALUES
('Yamaha', 'Japan'),
('Honda', 'Japan'),
('Ducati', 'Italy'),
('Suzuki', 'Japan'),
('KTM', 'Austria'),
('Aprilia', 'Italy'),
('Tech3', 'France'),
('LCR Honda', 'Japan'),
('Pramac Racing', 'Italy'),
('Petronas Yamaha', 'Malaysia');

-- Populate Piloto
INSERT INTO `Piloto` (`Nome`, `Pais`, `Time_Nome`) VALUES
('Valentino Rossi', 'Italy', 'Yamaha'),
('Marc Marquez', 'Spain', 'Honda'),
('Andrea Dovizioso', 'Italy', 'Ducati'),
('Maverick Vinales', 'Spain', 'Yamaha'),
('Fabio Quartararo', 'France', 'Yamaha'),
('Joan Mir', 'Spain', 'Suzuki'),
('Francesco Bagnaia', 'Italy', 'Ducati'),
('Aleix Espargaro', 'Spain', 'Aprilia'),
('Pol Espargaro', 'Spain', 'KTM'),
('Jack Miller', 'Australia', 'Ducati'),
('Takaaki Nakagami', 'Japan', 'Honda'),
('Alex Rins', 'Spain', 'Suzuki'),
('Miguel Oliveira', 'Portugal', 'KTM'),
('Brad Binder', 'South Africa', 'KTM'),
('Enea Bastianini', 'Italy', 'Ducati'),
('Jorge Martin', 'Spain', 'Pramac Racing'),
('Luca Marini', 'Italy', 'Ducati'),
('Marco Bezzecchi', 'Italy', 'Ducati'),
('Franco Morbidelli', 'Italy', 'Petronas Yamaha'),
('Stefan Bradl', 'Germany', 'Honda'),
('Danilo Petrucci', 'Italy', 'Tech3'),
('Cal Crutchlow', 'UK', 'LCR Honda'),
('Johann Zarco', 'France', 'Pramac Racing'),
('Iker Lecuona', 'Spain', 'Tech3'),
('Alex Marquez', 'Spain', 'LCR Honda'),
('Tito Rabat', 'Spain', 'Pramac Racing');

-- Populate Mecanico
INSERT INTO `Mecanico` (`Especialidade`, `Nome`, `Time_Nome`) VALUES
('Engine', 'Hiroshi Aoyama', 'Honda'),
('Suspension', 'Gabriele Conti', 'Yamaha'),
('Electronics', 'Andrea Bonnani', 'Ducati'),
('Engine', 'Katsuaki Fujiwara', 'Suzuki'),
('Suspension', 'Matthias Schnitzer', 'KTM'),
('Electronics', 'Lorenzo Romagnoli', 'Aprilia'),
('Engine', 'Toru Ukawa', 'Honda'),
('Suspension', 'Marco Rigamonti', 'Ducati'),
('Electronics', 'Daniele Romagnoli', 'Yamaha'),
('Engine', 'Tommy O’Neil', 'Suzuki'),
('Suspension', 'Davide Marelli', 'KTM'),
('Electronics', 'Fabio Sterlacchini', 'Ducati'),
('Engine', 'Max Biaggi', 'Tech3'),
('Suspension', 'Nicky Hayden', 'LCR Honda'),
('Electronics', 'Carlos Checa', 'Pramac Racing'),
('Engine', 'Jeremy Burgess', 'Yamaha'),
('Suspension', 'Juan Martinez', 'Ducati'),
('Electronics', 'Christian Pupulin', 'Honda'),
('Engine', 'Tom Houseworth', 'Suzuki'),
('Suspension', 'Mike Leitner', 'KTM');

-- Populate Circuito
INSERT INTO `Circuito` (`Nome`, `Pais`, `Comprimento`) VALUES
('Circuito de Jerez', 'Spain', 4.428),
('Circuit of the Americas', 'USA', 5.513),
('Le Mans', 'France', 4.185),
('Mugello', 'Italy', 5.245),
('Catalunya', 'Spain', 4.655),
('Assen', 'Netherlands', 4.555),
('Silverstone', 'UK', 5.901),
('Red Bull Ring', 'Austria', 4.318),
('Misano', 'Italy', 4.226),
('Sepang', 'Malaysia', 5.543),
('Phillip Island', 'Australia', 4.448),
('Losail', 'Qatar', 5.380),
('Sachsenring', 'Germany', 3.671),
('Brno', 'Czech Republic', 5.403),
('Valencia', 'Spain', 4.005);

-- Populate Corrida
INSERT INTO `Corrida` (`Data`, `Circuito_idCircuito`) VALUES
('2023-03-28', 1),
('2023-04-11', 2),
('2023-05-02', 3),
('2023-05-30', 4),
('2023-06-06', 5),
('2023-06-27', 6),
('2023-07-11', 7),
('2023-08-15', 8),
('2023-09-12', 9),
('2023-10-03', 10),
('2023-10-24', 11),
('2023-11-07', 12),
('2023-11-28', 13),
('2023-12-12', 14),
('2023-12-19', 15);

-- Populate Temporada
INSERT INTO `Temporada` (`Ano`) VALUES
(2022),
(2023),
(2024);

-- Populate Classificacao
INSERT INTO `Classificacao` (`Pontos`, `Piloto_idPiloto`, `Temporada_Ano`, `Corrida_idCorrida`) VALUES
(25, 1, 2023, 1),
(20, 2, 2023, 1),
(16, 3, 2023, 1),
(13, 4, 2023, 1),
(11, 5, 2023, 1),
(10, 6, 2023, 1),
(9, 7, 2023, 1),
(8, 8, 2023, 1),
(7, 9, 2023, 1),
(6, 10, 2023, 1),
(25, 2, 2023, 2),
(20, 3, 2023, 2),
(16, 4, 2023, 2),
(13, 5, 2023, 2),
(11, 6, 2023, 2),
(10, 7, 2023, 2),
(9, 8, 2023, 2),
(8, 9, 2023, 2),
(7, 10, 2023, 2),
(6, 1, 2023, 2),
(25, 3, 2023, 3),
(20, 4, 2023, 3),
(16, 5, 2023, 3),
(13, 6, 2023, 3),
(11, 7, 2023, 3),
(10, 8, 2023, 3),
(9, 9, 2023, 3),
(8, 10, 2023, 3),
(7, 1, 2023, 3),
(6, 2, 2023, 3),
(25, 4, 2023, 4),
(20, 5, 2023, 4),
(16, 6, 2023, 4),
(13, 7, 2023, 4),
(11, 8, 2023, 4),
(10, 9, 2023, 4),
(9, 10, 2023, 4),
(8, 1, 2023, 4),
(7, 2, 2023, 4),
(6, 3, 2023, 4);

-- Populate AppUser
INSERT INTO `AppUser` (`Usuario`, `Email`, `Senha`) VALUES
('fan1', 'fan1@example.com', 'password123'),
('fan2', 'fan2@example.com', 'password123'),
('journalist1', 'journalist1@example.com', 'password123'),
('fan3', 'fan3@example.com', 'password123'),
('fan4', 'fan4@example.com', 'password123'),
('journalist2', 'journalist2@example.com', 'password123');

-- Populate Favorito
INSERT INTO `Favorito` (`AppUser_Email`, `Piloto_idPiloto`, `Piloto_Time_Nome`) VALUES
('fan1@example.com', 1, 'Yamaha'),
('fan1@example.com', 2, 'Honda'),
('fan2@example.com', 3, 'Ducati'),
('fan2@example.com', 4, 'Yamaha'),
('journalist1@example.com', 5, 'Yamaha'),
('fan3@example.com', 6, 'Suzuki'),
('fan3@example.com', 7, 'Ducati'),
('fan4@example.com', 8, 'Aprilia'),
('fan4@example.com', 9, 'KTM'),
('journalist2@example.com', 10, 'Ducati');

-- Populate Comentario
INSERT INTO `Comentario` (`AppUser_Email`, `Texto`, `Corrida_idCorrida`) VALUES
('fan1@example.com', 'Amazing race by Rossi!', 1),
('fan2@example.com', 'Marquez was unstoppable!', 1),
('journalist1@example.com', 'Great strategy by Yamaha.', 1),
('fan3@example.com', 'Incredible race by Mir!', 2),
('fan4@example.com', 'Exciting finish!', 2),
('journalist2@example.com', 'Impressive performance by Ducati.', 2);

-- Populate Patrocinador
INSERT INTO `Patrocinador` (`Nome`, `Pais`) VALUES
('Red Bull', 'Austria'),
('Monster Energy', 'USA'),
('Michelin', 'France'),
('Repsol', 'Spain'),
('Petronas', 'Malaysia'),
('Shell', 'UK');

-- Populate Patrocinio
INSERT INTO `Patrocinio` (`Patrocinador_Nome`, `Time_Nome`) VALUES
('Red Bull', 'Honda'),
('Monster Energy', 'Yamaha'),
('Michelin', 'Ducati'),
('Repsol', 'Honda'),
('Petronas', 'Yamaha'),
('Shell', 'Ducati'),
('Red Bull', 'KTM'),
('Monster Energy', 'Suzuki'),
('Michelin', 'Aprilia'),
('Petronas', 'Petronas Yamaha');