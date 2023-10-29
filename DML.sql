-- ARTISTAS
INSERT INTO artistas (nome) VALUES ('Taylor Swift'), ('Troye Sivan'), ('Doja Cat'), ('Calvin Harris'), ('Anitta'), ('Demi Lovato'), ('Lady Gaga'), ('Ariana Grande');

-- GENEROS
INSERT INTO generos (nome) VALUES
('Pop'), ('Rock'), ('Hip Hop'), ('Eletrônica'), ('R&B'), ('Indie'), ('Alternativo'), ('Country');

-- ALBUNS
INSERT INTO albuns (titulo, artistaID, generoID, anoLancamento) VALUES
('Lover', 1, 1, 2019),
('Kisses', 5, 1, 2019),
('Funk Wav Bounces Vol. 1', 4, 4, 2017),
('Planet Her', 3, 3, 2021);

-- Inserção dos álbuns da Taylor Swift
INSERT INTO albuns (titulo, artistaID, generoID, anoLancamento) VALUES 
('Taylor Swift', 1, 7, 2006),
('Fearless', 1, 7, 2008),
('Speak Now', 1, 7, 2010),
('Red', 1, 2, 2012),
('1989', 1, 1, 2014),
('Reputation', 1, 1, 2017),
('Lover', 1, 1, 2019),
('Folklore', 1, 6, 2020),
('Evermore', 1, 6, 2020);

-- Inserção dos álbuns da Anitta
INSERT INTO albuns (titulo, artistaID, generoID, anoLancamento) VALUES 
('Anitta', 5, 1, 2013),
('Ritmo Perfeito', 5, 1, 2014),
('Bang', 5, 1, 2015);

-- USUARIOS
INSERT INTO usuarios (username, email, senha, dataRegistro) VALUES 
('feslipebraga', 'feslipebraga@gmail.com', 'xyc720208', '2023-10-22 15:42:29'),
('AnaSilva', 'ana.silva@email.com', 'P@ssw0rd', '2023-10-01 10:30:45'),
('CarlosSantos', 'carlos.santos@email.com', 'SecurePass123', '2023-10-02 11:25:30'),
('MarianaLima', 'mariana.lima@email.com', 'StrongPwd!234', '2023-10-03 12:15:20'),
('PedroPereira', 'pedro.pereira@email.com', 'P@ssTweeter', '2023-10-04 14:45:55'),
('CamilaRodrigues', 'camila.rodrigues@email.com', 'SnaPw0rd', '2023-10-05 16:20:10'),
('RafaelMartins', 'rafael.martins@email.com', 'BookL0ver!', '2023-10-06 18:05:35'),
('JulianaFernandes', 'juliana.fernandes@email.com', 'GeekP@ss', '2023-10-07 20:40:45'),
('LucasOliveira', 'lucas.oliveira@email.com', 'MusiC@tunes', '2023-10-08 22:15:55'),
('AmandaCosta', 'amanda.costa@email.com', 'G@merP@ss', '2023-10-09 23:59:59'),
('MarcosSousa', 'marcos.sousa@email.com', 'Wanderl#st1', '2023-10-10 09:30:15');

-- PLAYLISTS
INSERT INTO playlists (nome) VALUES ('Today''s Top Hits'), ('RapCaviar'), ('Hot Country'), ('Mint'), ('Viva Latino'), ('New Music Friday'), ('Peaceful Piano'), ('All Out ''60s'), ('Rock Classics'), ('90s Smash Hits');

--PLAYLISTS_MUSICAS
-- Inserção das músicas na playlist "Today's Top Hits"
INSERT INTO musicas_playlists (musicaID, playlistID) VALUES 
(1, 1),(4, 1),(7, 1),(9, 1),(12, 1),(15, 1),(18, 1),(21, 1),(24, 1),(27, 1);

-- Inserção das músicas na playlist "RapCaviar"
INSERT INTO musicas_playlists (musicaID, playlistID) VALUES 
(2, 2),(5, 2),(8, 2),(10, 2),(13, 2),(16, 2),(19, 2),(22, 2),(25, 2),(28, 2);

-- Inserção das músicas na playlist "Hot Country"
INSERT INTO musicas_playlists (musicaID, playlistID) VALUES 
(3, 3),(6, 3),(11, 3),(14, 3),(17, 3),(20, 3),(23, 3),(26, 3),(29, 3),(30, 3);

-- Inserção das músicas na playlist "Mint"
INSERT INTO musicas_playlists (musicaID, playlistID) VALUES 
(31, 4),(32, 4),(33, 4),(34, 4),(35, 4),(36, 4),(37, 4),(38, 4),(39, 4),(40, 4);

-- Inserção das músicas na playlist "Viva Latino"
INSERT INTO musicas_playlists (musicaID, playlistID) VALUES 
(41, 5),(42, 5),(43, 5),(44, 5),(45, 5),(46, 5),(47, 5),(48, 5),(49, 5),(50, 5);
