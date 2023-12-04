-- USUARIOS
CREATE USER felipebraga WITH PASSWORD 'admin@7$' SUPERUSER;
CREATE USER emersonfranco WITH PASSWORD 'admin&!9' SUPERUSER;
CREATE USER user WITH PASSWORD 'user281';

-- GRUPOS 
CREATE GROUP administradores WITH NOLOGIN; -- Criar um grupo de administradores
GRANT administradores TO felipebraga, emersonfranco; -- Adiciona usuários ao grupo de administradores

CREATE GROUP usuarios_regulares WITH NOLOGIN; -- Cria um grupo de usuários regulares
GRANT usuarios_regulares TO user; -- Adiciona user ao grupo de usuários regulares

-- Concedendo permissões para os grupos.
GRANT ALL PRIVILEGES ON DATABASE MusicAPP TO administradores;
GRANT INSERT, UPDATE, DELETE ON artistas, musicas, albuns, generos TO usuarios_regulares;

-- Criando usuario limitado que terá acesso somente as views
CREATE USER views_user WITH PASSWORD 'regularuserVIEW';
GRANT SELECT ON v_detalhes_musicas_playlist TO views_user;
GRANT SELECT ON v_usuarios_playlists TO views_user;
GRANT SELECT ON v_info_usuarios TO views_user;
GRANT SELECT ON v_favoritos_usuarios TO views_user;
GRANT SELECT ON v_albuns_musicas_artista TO views_user;

-- Para remover todas as permissões que foram concedidas ao usuário.
REVOKE ALL ON DATABASE MusicAPP FROM usuarios_regulares;

-- Permitir que o usuário se conecte ao BD mas não concede acesso a nenhuma tabela ou funcionalidade dentro dele.
GRANT CONNECT ON DATABASE MusicAPP TO usuarios_regulares;

-- Criando usuario de backup
CREATE USER backup_user WITH PASSWORD 'BSI2022';
GRANT pg_read_all_settings TO backup_user;
GRANT pg_dump TO backup_user;

-- Backup do BD
pg_dump -U backup_user -d MusicAPP -F plain -f "C:\Users\Felipe\Desktop\backup_MusicAPP.sql"

-- Restore do BD
psql -U felipebraga -d bd_recuperado -f "C:\Users\Felipe\Desktop\backup_MusicAPP.sql"