-- View para exibir informações detalhadas das músicas presentes em uma playlist.

CREATE OR REPLACE VIEW v_detalhes_musicas_playlist AS
SELECT p.nome AS nome_playlist, m.titulo AS titulo_musica, a.nome AS nome_artista, m.duracao AS duracao_musica
FROM playlists p
JOIN musicasPlaylists mp ON p.id = mp.playlistID
JOIN musicas m ON mp.musicaID = m.id
JOIN artistas a ON m.artistaID = a.id;

-- View para listar os usuários e suas respectivas playlists criadas.

CREATE OR REPLACE VIEW v_usuarios_playlists AS
SELECT u.username AS nome_usuario, p.nome AS nome_playlist
FROM usuarios u
LEFT JOIN playlists p ON u.id = p.criadorID;

-- View para exibir informações básicas dos usuários
CREATE VIEW v_info_usuarios AS
SELECT id, username, email, dataRegistro
FROM usuarios;

-- View para listar os artistas favoritos de cada usuário
CREATE VIEW v_favoritos_usuarios AS
SELECT AF.usuarioID, U.username AS usuario, A.nome AS artista
FROM artistasFavoritos AF
JOIN usuarios U ON AF.usuarioID = U.id
JOIN artistas A ON AF.artistaID = A.id;

-- View para mostrar os álbuns e músicas associadas a cada artista
CREATE VIEW v_albuns_musicas_artista AS
SELECT A.nome AS artista, AL.titulo AS album, M.titulo AS musica
FROM artistas A
LEFT JOIN albuns AL ON A.id = AL.artistaID
LEFT JOIN musicas M ON AL.id = M.albumID;