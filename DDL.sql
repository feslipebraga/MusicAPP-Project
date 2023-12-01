DROP TABLE IF EXISTS artistas;
DROP TABLE IF EXISTS generos;
DROP TABLE IF EXISTS albuns;
DROP TABLE IF EXISTS musicas;
DROP TABLE IF EXISTS playlists;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS musicas_playlists;
DROP TABLE IF EXISTS artistas_favoritados;
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

CREATE TABLE musicas_playlists (
    musicaID INTEGER NOT NULL,
    playlistID INTEGER NOT NULL,
    FOREIGN KEY (musicaID) REFERENCES musicas(id) ON DELETE CASCADE,
    FOREIGN KEY (playlistID) REFERENCES playlists(id) ON DELETE CASCADE,
    PRIMARY KEY (musicaID, playlistID)
);

CREATE TABLE artistas_favoritados (
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
