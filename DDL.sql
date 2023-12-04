DROP TABLE IF EXISTS artistas;
DROP TABLE IF EXISTS generos;
DROP TABLE IF EXISTS albuns;
DROP TABLE IF EXISTS musicas;
DROP TABLE IF EXISTS playlists;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS musicasPlaylists;
DROP TABLE IF EXISTS artistasFavoritados;
DROP TABLE IF EXISTS follows;
DROP TABLE IF EXISTS musicasEscutadas;

-- Criando os domínios
CREATE DOMAIN dm_pequeno AS VARCHAR(20) NOT NULL;
CREATE DOMAIN dm_medio AS VARCHAR(50) NOT NULL;
CREATE DOMAIN dm_grande AS VARCHAR(100) NOT NULL;

-- 	Criando as tabelas
CREATE TABLE artistas(
    id SERIAL PRIMARY KEY,
    nome dm_medio UNIQUE
);

CREATE TABLE generos (
    id SERIAL PRIMARY KEY,
    nome dm_pequeno UNIQUE
);

CREATE TABLE albuns(
    id SERIAL PRIMARY KEY,
    titulo dm_grande,
    artistaID INTEGER,
    generoID INTEGER,
    anoLancamento INTEGER
    CHECK (anoLancamento <= EXTRACT(YEAR FROM CURRENT_DATE)),
    FOREIGN KEY (artistaID) REFERENCES artistas(id) ON DELETE CASCADE,
    FOREIGN KEY (generoID) REFERENCES generos(id) ON DELETE CASCADE
);

CREATE TABLE musicas(
    id SERIAL PRIMARY KEY,
    titulo dm_grande,
    duracao interval,
    artistaID INTEGER,
    albumID INTEGER,
    FOREIGN KEY (artistaID) references artistas(id) ON DELETE CASCADE,
    FOREIGN KEY (albumID) references albuns(id) ON DELETE CASCADE
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    username dm_medio UNIQUE,
    email dm_grande UNIQUE,
    senha dm_grande,
    dataRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE playlists(
    id SERIAL PRIMARY KEY,
    nome dm_grande,
    criadorID INTEGER NOT NULL,
    dataCriacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataModificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (criadorID) references usuarios(id) ON DELETE CASCADE
);

CREATE TABLE musicasPlaylists (
    musicaID INTEGER NOT NULL,
    playlistID INTEGER NOT NULL,
    FOREIGN KEY (musicaID) REFERENCES musicas(id) ON DELETE CASCADE,
    FOREIGN KEY (playlistID) REFERENCES playlists(id) ON DELETE CASCADE,
    PRIMARY KEY (musicaID, playlistID)
);

CREATE TABLE artistasFavoritos (
    usuarioID INTEGER NOT NULL,
    artistaID INTEGER NOT NULL,
    FOREIGN KEY (usuarioID) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (artistaID) REFERENCES artistas(id) ON DELETE CASCADE
);

CREATE TABLE follows (
    seguidorID INTEGER NOT NULL,
    seguidoID INTEGER NOT NULL,
    dataFollow TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seguidorID) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (seguidoID) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE musicasEscutadas (
    usuarioID INTEGER NOT NULL,
    musicaID INTEGER NOT NULL,
    dataReproducao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuarioID) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (musicaID) REFERENCES musicas(id) ON DELETE CASCADE
);

-- INSERTS

-- Inserindo valores para a tabela artistas
INSERT INTO artistas (nome) VALUES
('Beyoncé'),
('Billie Eilish'),
('Taylor Swift'),
('Anitta'),
('Marília Mendonça');

-- Inserindo valores para a tabela generos
INSERT INTO generos (nome) VALUES
('Pop'),
('Indie'),
('Country'),
('Funk'),
('Sertanejo');

-- Inserindo valores para a tabela albuns
INSERT INTO albuns (titulo, artistaID, generoID, anoLancamento) VALUES
('Lemonade', 1, 1, 2016),
('When We All Fall Asleep, Where Do We Go?', 2, 2, 2019),
('Red (Taylor''s Version)', 3, 3, 2021),
('Kisses', 4, 4, 2020),
('Todos os Cantos', 5, 5, 2019);

-- Inserindo valores para a tabela musicas
INSERT INTO musicas (numero, titulo, duracao, artistaID, albumID) VALUES
(1, 'Pray You Catch Me', INTERVAL '3 minutes 16 seconds', 1, 1),
(2, 'Hold Up', INTERVAL '3 minutes 41 seconds', 1, 1),
(3, 'Don''t Hurt Yourself', INTERVAL '3 minutes 53 seconds', 1, 1),
(4, 'Sorry', INTERVAL '3 minutes 53 seconds', 1, 1),
(5, '6 Inch', INTERVAL '4 minutes 20 seconds', 1, 1),
(6, 'Daddy Lessons', INTERVAL '4 minutes 37 seconds', 1, 1),
(7, 'Love Drought', INTERVAL '3 minutes 57 seconds', 1, 1),
(8, 'Sandcastles', INTERVAL '3 minutes 03 seconds', 1, 1),
(9, 'Forward', INTERVAL '1 minute 19 seconds', 1, 1),
(10, 'Freedom', INTERVAL '4 minutes 50 seconds', 1, 1),
(11, 'All Night', INTERVAL '5 minutes 21 seconds', 1, 1),
(12, 'Formation', INTERVAL '3 minutes 26 seconds', 1, 1),

(1, '!!!!!!!', INTERVAL '14 seconds', 2, 2),
(2, 'bad guy', INTERVAL '3 minutes 14 seconds', 2, 2),
(3, 'xanny', INTERVAL '4 minutes 4 seconds', 2, 2),
(4, 'you should see me in a crown', INTERVAL '3 minutes 0 seconds', 2, 2),
(5, 'all the good girls go to hell', INTERVAL '2 minutes 49 seconds', 2, 2),
(6, 'wish you were gay', INTERVAL '3 minutes 41 seconds', 2, 2),
(7, 'when the party''s over', INTERVAL '3 minutes 16 seconds', 2, 2),
(8, '8', INTERVAL '2 minutes 53 seconds', 2, 2),
(9, 'my strange addiction', INTERVAL '3 minutes 0 seconds', 2, 2),
(10, 'bury a friend', INTERVAL '3 minutes 13 seconds', 2, 2),
(11, 'ilomilo', INTERVAL '2 minutes 36 seconds', 2, 2),
(12, 'listen before i go', INTERVAL '4 minutes 2 seconds', 2, 2),
(13, 'i love you', INTERVAL '4 minutes 52 seconds', 2, 2),
(14, 'goodbye', INTERVAL '1 minute 59 seconds', 2, 2),

(1, 'State of Grace (Taylor''s Version)', INTERVAL '4 minutes 55 seconds', 3, 3),
(2, 'Red (Taylor''s Version)', INTERVAL '3 minutes 43 seconds', 3, 3),
(3, 'Treacherous (Taylor''s Version)', INTERVAL '4 minutes 0 seconds', 3, 3),
(4, 'I Knew You Were Trouble (Taylor''s Version)', INTERVAL '3 minutes 39 seconds', 3, 3),
(5, 'All Too Well (10 Minute Version) (Taylor''s Version)', INTERVAL '10 minutes 13 seconds', 3, 3),
(6, '22 (Taylor''s Version)', INTERVAL '3 minutes 52 seconds', 3, 3),
(7, 'I Almost Do (Taylor''s Version)', INTERVAL '4 minutes 4 seconds', 3, 3),
(8, 'We Are Never Ever Getting Back Together (Taylor''s Version)', INTERVAL '3 minutes 13 seconds', 3, 3),
(9, 'Stay Stay Stay (Taylor''s Version)', INTERVAL '3 minutes 25 seconds', 3, 3),
(10, 'The Last Time (Taylor''s Version)', INTERVAL '4 minutes 59 seconds', 3, 3),
(11, 'Holy Ground (Taylor''s Version)', INTERVAL '3 minutes 22 seconds', 3, 3),
(12, 'Sad Beautiful Tragic (Taylor''s Version)', INTERVAL '4 minutes 44 seconds', 3, 3),
(13, 'The Lucky One (Taylor''s Version)', INTERVAL '4 minutes 0 seconds', 3, 3),
(14, 'Everything Has Changed (Taylor''s Version)', INTERVAL '4 minutes 6 seconds', 3, 3),
(15, 'Starlight (Taylor''s Version)', INTERVAL '3 minutes 41 seconds', 3, 3),
(16, 'Begin Again (Taylor''s Version)', INTERVAL '3 minutes 58 seconds', 3, 3),
(17, 'The Moment I Knew (Taylor''s Version)', INTERVAL '4 minutes 46 seconds', 3, 3),
(18, 'Come Back... Be Here (Taylor''s Version)', INTERVAL '3 minutes 45 seconds', 3, 3),
(19, 'Girl at Home (Taylor''s Version)', INTERVAL '3 minutes 41 seconds', 3, 3),
(20, 'Treason (Taylor''s Version)', INTERVAL '4 minutes 18 seconds', 3, 3),
(21, 'Ronan (Taylor''s Version)', INTERVAL '4 minutes 26 seconds', 3, 3),
(22, 'Better Man (Taylor''s Version)', INTERVAL '4 minutes 07 seconds', 3, 3),
(23, 'Nothing New (Taylor''s Version)', INTERVAL '3 minutes 55 seconds', 3, 3),
(24, 'Babe (Taylor''s Version)', INTERVAL '3 minutes 31 seconds', 3, 3),
(25, 'Message In A Bottle (Taylor''s Version)', INTERVAL '4 minutes 06 seconds', 3, 3),
(26, 'I Bet You Think About Me (Taylor''s Version)', INTERVAL '3 minutes 30 seconds', 3, 3),
(27, 'Forever Winter (Taylor''s Version)', INTERVAL '4 minutes 14 seconds', 3, 3),
(28, 'Run (Taylor''s Version)', INTERVAL '3 minutes 38 seconds', 3, 3),
(29, 'The Very First Night (Taylor''s Version)', INTERVAL '4 minutes 16 seconds', 3, 3),
(30, 'All Too Well (Taylor''s Version)', INTERVAL '5 minutes 28 seconds', 3, 3),

(1, 'Atenção', INTERVAL '2 minutes 36 seconds', 4, 4),
(2, 'Banana', INTERVAL '2 minutes 58 seconds', 4, 4),
(3, 'Onda Diferente', INTERVAL '2 minutes 48 seconds', 4, 4),
(4, 'Sin Miedo', INTERVAL '3 minutes 13 seconds', 4, 4),
(5, 'Poquito', INTERVAL '3 minutes 13 seconds', 4, 4),
(6, 'Tu y Yo', INTERVAL '2 minutes 55 seconds', 4, 4),
(7, 'Get to Know Me', INTERVAL '2 minutes 49 seconds', 4, 4),
(8, 'Rosa', INTERVAL '2 minutes 43 seconds', 4, 4),
(9, 'Juego', INTERVAL '3 minutes 32 seconds', 4, 4),
(10, 'Você Mentiu', INTERVAL '2 minutes 41 seconds', 4, 4),

(1, 'Todo Mundo Vai Sofrer', INTERVAL '2 minutes 47 seconds', 5, 5),
(2, 'Bebi Liguei', INTERVAL '2 minutes 44 seconds', 5, 5),
(3, 'Supera', INTERVAL '2 minutes 58 seconds', 5, 5),
(4, 'Ciumeira', INTERVAL '2 minutes 55 seconds', 5, 5),
(5, 'Love à Queima Roupa', INTERVAL '2 minutes 37 seconds', 5, 5),
(6, 'Bem Pior Que Eu', INTERVAL '2 minutes 57 seconds', 5, 5),
(7, 'Obrigado Por Estragar Tudo', INTERVAL '2 minutes 49 seconds', 5, 5),
(8, 'Bye Bye', INTERVAL '2 minutes 36 seconds', 5, 5),
(9, 'Passa Mal', INTERVAL '2 minutes 28 seconds', 5, 5),
(10, 'Casa da Mãe Joana', INTERVAL '3 minutes 11 seconds', 5, 5),
(11, 'Todo Mundo Vai Sofrer (Ao Vivo)', INTERVAL '2 minutes 43 seconds', 5, 5),
(12, 'Ciumeira (Ao Vivo)', INTERVAL '2 minutes 58 seconds', 5, 5),
(13, 'Bebi Liguei (Ao Vivo)', INTERVAL '2 minutes 39 seconds', 5, 5),
(14, 'Love à Queima Roupa (Ao Vivo)', INTERVAL '2 minutes 32 seconds', 5, 5),
(15, 'Bem Pior Que Eu (Ao Vivo)', INTERVAL '2 minutes 46 seconds', 5, 5),
(16, 'Obrigado Por Estragar Tudo (Ao Vivo)', INTERVAL '2 minutes 51 seconds', 5, 5),
(17, 'Passa Mal (Ao Vivo)', INTERVAL '2 minutes 27 seconds', 5, 5),
(18, 'Casa da Mãe Joana (Ao Vivo)', INTERVAL '2 minutes 59 seconds', 5, 5);

-- Inserindo valores para a tabela usuarios
INSERT INTO usuarios (username, email, senha, dataRegistro) VALUES 
('AnaSilva', 'ana.silva@email.com', 'P@ssw0rd'),
('CarlosSantos', 'carlos.santos@email.com', 'SecurePass123', '2023-09-10 11:25:30'),
('MarianaLima', 'mariana.lima@email.com', 'StrongPwd!234', '2023-08-03 12:15:20'),
('PedroPereira', 'pedro.pereira@email.com', 'P@ssTweeter'),
('CamilaRodrigues', 'camila.rodrigues@email.com', 'SnaPw0rd', '2023-06-05 16:20:10'),
('RafaelMartins', 'rafael.martins@email.com', 'BookL0ver!', '2023-01-10 18:05:35'),
('JulianaFernandes', 'juliana.fernandes@email.com', 'GeekP@ss', '2023-02-07 20:40:45'),
('LucasOliveira', 'lucas.oliveira@email.com', 'MusiC@tunes', '2023-10-08 22:15:55'),
('AmandaCosta', 'amanda.costa@email.com', 'G@merP@ss', '2023-07-09 23:59:59'),
('MarcosSousa', 'marcos.sousa@email.com', 'Wanderl#st1', '2023-08-10 09:30:15');

-- Inserindo valores para a tabela playlists

INSERT INTO playlists (nome, criadorID, dataCriacao) VALUES 
('Músicas Curtidas', 1, DEFAULT), 
('Músicas Relaxantes', 3, '2023-09-20 14:45:00'), 
('Party Time!', 7, '2023-10-01 18:00:00');

-- Inserindo valores para a tabela musicasPlaylists
INSERT INTO musicasPlaylists (musicaID, playlistID) VALUES 
(14, 1), (27, 1), (33, 1), (41, 1), (12, 1), 
(66, 2), (14, 2), (80, 2), (9, 2), (1, 2), 
(10, 3), (43, 3), (26, 3), (80, 3), (9, 3); 

-- Inserindo valores para a tabela artistasFavoritos
INSERT INTO artistasFavoritos (usuarioID, artistaID) VALUES 
(1, 1), (1, 5), (2, 3), (3, 1), (3, 4), (4, 2), (4, 5), (5, 5), (5, 2), (5, 1), (6, 4), (9, 3), (10, 4);

-- Inserindo valores para a tabela follows
INSERT INTO follows (seguidorID, seguidoID) VALUES 
(1, 1), (1, 5), (1, 3), (1, 1), (1, 4), (2, 2), (2, 5), (3, 5), (4, 2), (4, 1), (4, 4), (4, 3), (5, 4), (5, 1), (5, 5), (5, 3), (5, 1), (5, 4), (5, 2), (6, 5), (7, 5), (8, 2), (8, 1), (9, 4), (9, 3), (9, 4);

-- Inserindo valores para a tabela musicasEscutadas
INSERT INTO musicasEscutadas (usuarioID, musicaID, dataReproducao) VALUES 
(1, 1, '2023-10-15 08:30:00'), (1, 5, '2023-10-15 10:00:00'), (1, 10, '2023-10-15 11:45:00'), (1, 12, '2023-10-15 13:20:00'), (1, 18, DEFAULT),
(2, 12, '2023-10-16 13:20:00'), (2, 56, '2023-10-16 14:30:00'), (2, 34, '2023-10-16 15:45:00'), (2, 23, '2023-10-16 17:00:00'), (2, 12, '2023-10-16 18:15:00'),
(3, 17, '2023-10-17 13:20:00'), (3, 57, '2023-10-17 14:30:00'), (3, 34, '2023-10-17 15:45:00'), (3, 38, '2023-10-17 17:00:00'), (3, 11, '2023-10-17 18:15:00'),
(4, 45, '2023-10-15 08:30:00'), (4, 43, '2023-10-18 14:30:00'), (4, 23, '2023-10-18 15:45:00'), (4, 12, '2023-10-18 17:00:00'), (4, 19, DEFAULT),
(5, 15, '2023-10-19 13:20:00'), (5, 13, '2023-10-19 14:30:00'), (5, 10, '2023-10-19 15:45:00'), (5, 4, '2023-10-19 17:00:00'), (5, 6, '2023-10-19 18:15:00'),
(6, 6, '2023-10-20 13:20:00'), (6, 1, '2023-10-20 14:30:00'), (6, 6, '2023-10-20 15:45:00'), (6, 35, '2023-10-20 17:00:00'), (6, 49, '2023-10-20 18:15:00'),
(7, 27, '2023-10-15 08:30:00'), (7, 12, '2023-10-21 14:30:00'), (7, 47, '2023-10-21 15:45:00'), (7, 48, '2023-10-21 17:00:00'), (7, 49, DEFAULT),
(9, 19, '2023-10-22 13:20:00'), (9, 12, '2023-10-22 14:30:00'), (9, 25, '2023-10-22 15:45:00'), (9, 51, '2023-10-22 17:00:00'), (9, 43, '2023-10-22 18:15:00'),
(10, 12, '2023-10-23 13:20:00'), (10, 16, '2023-10-23 14:30:00'), (10, 18, '2023-10-23 15:45:00'), (10, 56, '2023-10-23 17:00:00'), (10, 13, DEFAULT);
