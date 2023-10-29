CREATE DOMAIN dm_vc20 AS VARCHAR(20);
CREATE DOMAIN dm_vc50 AS VARCHAR(50);
CREATE DOMAIN dm_vc255 AS VARCHAR(255);

-- 	Nome, view: discografia, view: playlists incluídas, view: albuns incluídos e biografia.
CREATE TABLE artistas(
    id SERIAL PRIMARY KEY,
    nome dm_vc50
);

CREATE TABLE generos (
    id SERIAL PRIMARY KEY,
    nome dm_vc20 UNIQUE
);

-- 	Título, view: lista de faixas, fk: artista, ano de lançamento, gênero e view: duração.
CREATE TABLE albuns(
    id SERIAL PRIMARY KEY,
    titulo dm_vc50,
    artistaID INTEGER,
    generoID INTEGER,
    anoLancamento INTEGER
    CHECK (anoLancamento <= EXTRACT(YEAR FROM CURRENT_DATE)),
    FOREIGN KEY (artistaID) REFERENCES artistas(id) ON DELETE CASCADE,
    FOREIGN KEY (generoID) REFERENCES generos(id) ON DELETE CASCADE
);

-- 	Título, duração, fk: artista, fk: álbum, join: gênero e join: ano de lançamento.
CREATE TABLE musicas(
    id SERIAL PRIMARY KEY,
    titulo dm_vc255,
    duracao interval,
    artistaID INTEGER,
    albumID INTEGER,
    FOREIGN KEY (artistaID) references artistas(id) ON DELETE CASCADE,
    FOREIGN KEY (albumID) references albuns(id) ON DELETE CASCADE
);

CREATE TABLE playlists(
    id SERIAL PRIMARY KEY,
    nome dm_vc50
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    username dm_vc50,
    email dm_vc255 UNIQUE,
    senha dm_vc255,
    dataRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE musicas_playlists (
    id SERIAL PRIMARY KEY,
    musicaID INTEGER,
    playlistID INTEGER,
    FOREIGN KEY (musicaID) REFERENCES musicas(id),
    FOREIGN KEY (playlistID) REFERENCES playlists(id)
);
