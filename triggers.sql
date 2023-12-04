-- Atualização automática da data de modificação de uma playlist:
-- Esta trigger atualiza a data de modificação de uma playlist sempre que uma música é adicionada à mesma

CREATE OR REPLACE FUNCTION f_AtualizarDataModificacaoPlaylist()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE playlists
    SET dataModificacao = CURRENT_TIMESTAMP
    WHERE id = NEW.playlistID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_TriggerAtualizarDataModificacao
AFTER INSERT ON musicasPlaylists
FOR EACH ROW
EXECUTE FUNCTION f_AtualizarDataModificacaoPlaylist();

/* A trigger t_TriggerAtualizarDataModificacao é acionada automaticamente após a inserção de uma nova entrada na tabela musicasPlaylists.
A função f_AtualizarDataModificacaoPlaylist, por sua vez, associa à trigger e atualiza a coluna dataModificacao na tabela playlists com a data e hora atuais sempre que uma música é adicionada a uma playlist. */