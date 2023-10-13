CREATE DOMAIN dm_vc20 AS VARCHAR(20);
CREATE DOMAIN dm_vc50 AS VARCHAR(50);
CREATE DOMAIN dm_vc255 AS VARCHAR(255);

-- 	Nome, view: ouvintes mensais, view: músicas populares, view: discografia, view: playlists incluídas, view: albuns incluídos e biografia.
CREATE TABLE artistas(
    id SERIAL PRIMARY KEY,
    nome dm_vc50,
    biografia dm_vc255
);

-- 	Título, view: lista de faixas, fk: artista, ano de lançamento, gênero e view: duração.
CREATE TABLE albuns(
    id SERIAL PRIMARY KEY,
    titulo dm_vc50,
    artistaID INTEGER,
    genero dm_vc20,
    anoLancamento YEAR
    CHECK (anoLancamento <= EXTRACT(YEAR FROM CURRENT_DATE)),
    FOREIGN KEY artistaID REFERENCES artistas(id) ON DELETE CASCADE
);

-- 	Título, duração, fk: artista, fk: álbum, join: gênero e join: ano de lançamento.
CREATE TABLE musicas(
    id SERIAL PRIMARY KEY,
    titulo dm_vc50,
    duracao interval,
    artistaID INTEGER,
    albumID INTEGER,
    FOREIGN KEY (artistaID) references artistas(id) ON DELETE CASCADE,
    FOREIGN KEY (albumID) references albuns(id) ON DELETE CASCADE
);
