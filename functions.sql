-- Calcular a duração total de todas as músicas em uma playlist:
/* Esta função calcula a duração total de todas as músicas em uma playlist.
Recebe o ID de uma playlist como parâmetro e retorna a duração total de todas as músicas nessa playlist como um valor de intervalo. */

CREATE OR REPLACE FUNCTION f_CalcularDuracaoTotalPlaylist(playlist_id INTEGER)
RETURNS INTERVAL
AS $$
DECLARE
    duracao_total INTERVAL;
BEGIN
    SELECT SUM(m.duracao)
    INTO duracao_total
    FROM musicas m
    INNER JOIN musicasPlaylists mp ON m.id = mp.musicaID
    WHERE mp.playlistID = playlist_id;
    RETURN duracao_total;
END;
$$ LANGUAGE plpgsql;

-- Verificar se um usuário segue outro usuário:
/* Esta função verifica se um usuário segue outro usuário.
Verifica se um usuário (seguidor_id) está seguindo outro usuário (seguido_id). Retorna verdadeiro se estiver seguindo ou falso se não estiver. */

CREATE OR REPLACE FUNCTION f_VerificarSegueUsuario(seguidor_id INTEGER, seguido_id INTEGER)
RETURNS BOOLEAN
AS $$
DECLARE
    segue BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM follows
        WHERE seguidorID = seguidor_id
        AND seguidoID = seguido_id
    )
    INTO segue;
    RETURN segue;
END;
$$ LANGUAGE plpgsql;