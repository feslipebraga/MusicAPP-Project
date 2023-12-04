-- Inner Join entre artistas, álbuns e músicas para listar todas as músicas de um determinado artista:

SELECT artistas.nome AS nome_artista, albuns.titulo AS titulo_album, musicas.titulo AS titulo_musica
FROM artistas
INNER JOIN albuns ON artistas.id = albuns.artistaID
INNER JOIN musicas ON albuns.id = musicas.albumID
WHERE artistas.nome = 'Beyoncé';

-- Left Join entre usuários e playlists para mostrar todas as playlists e seus criadores (se existirem):

SELECT playlists.nome AS nome_playlist, usuarios.username AS criador
FROM playlists
LEFT JOIN usuarios ON playlists.criadorID = usuarios.id;

-- Full Outer Join entre usuários e músicas escutadas para exibir todas as músicas escutadas por cada usuário (incluindo as que não foram escutadas):

SELECT usuarios.username AS usuario, musicas.titulo AS musica_escutada
FROM usuarios
FULL OUTER JOIN musicasEscutadas ON usuarios.id = musicasEscutadas.usuarioID
LEFT JOIN musicas ON musicasEscutadas.musicaID = musicas.id;

-- Inner Join entre artistas favoritos, usuários e artistas para mostrar os artistas favoritos de cada usuário:

SELECT usuarios.username AS usuario, artistas.nome AS artista_favorito
FROM usuarios
INNER JOIN artistasFavoritos ON usuarios.id = artistasFavoritos.usuarioID
INNER JOIN artistas ON artistasFavoritos.artistaID = artistas.id;

-- Right Join entre músicas e playlists para exibir todas as músicas de uma playlist específica (se existirem):

SELECT playlists.nome AS nome_playlist, musicas.titulo AS musica_na_playlist
FROM playlists
RIGHT JOIN musicasPlaylists ON playlists.id = musicasPlaylists.playlistID
RIGHT JOIN musicas ON musicasPlaylists.musicaID = musicas.id
WHERE playlists.nome = 'Músicas Curtidas';

-- Inner Join para verificar quais são os artistas mais ouvidos:

SELECT a.nome AS artista, COUNT(me.musicaID) AS reproducoes
FROM musicasEscutadas me
JOIN musicas m ON me.musicaID = m.id
JOIN artistas a ON m.artistaID = a.id
GROUP BY a.nome
ORDER BY reproducoes DESC;