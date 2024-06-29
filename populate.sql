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
('Engine', 'Tommy O Neil', 'Suzuki'),
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