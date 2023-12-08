-- Buscar informações de um usuário pelo ID:
/* Esta SP busca informações de um usuário com base no ID fornecido como parâmetro.
Recebe um ID de usuário como parâmetro e retorna todas as informações desse usuário da tabela usuarios. */

CREATE OR REPLACE PROCEDURE p_BuscarUsuarioPorID(IN id_usuario INTEGER)
AS $$
BEGIN
    SELECT *
    FROM usuarios
    WHERE id = id_usuario;
END;
$$ LANGUAGE plpgsql;

-- Adicionar uma nova música à playlist de um usuário:
/* Esta SP adiciona uma nova música à playlist de um usuário.
Permite que um usuário adicione uma música específica (id_musica) a uma playlist (id_playlist) que ele criou. Verifica se o usuário é o criador da playlist antes de adicionar a música. */

CREATE OR REPLACE PROCEDURE p_AdicionarMusicaPlaylist(
    IN id_usuario INTEGER,
    IN id_musica INTEGER,
    IN id_playlist INTEGER
)
AS $$
BEGIN
    -- Verifica se a playlist existe e se o usuario é o criador
    IF EXISTS (
        SELECT 1
        FROM playlists
        WHERE id = id_playlist
        AND criadorID = id_usuario
    ) THEN
        -- Adiciona a música na playlist
        INSERT INTO musicasPlaylists (musicaID, playlistID)
        VALUES (id_musica, id_playlist);
    ELSE
        RAISE EXCEPTION 'Playlist não encontrada ou o usuário não é o criador';
    END IF;
END;
$$ LANGUAGE plpgsql;
