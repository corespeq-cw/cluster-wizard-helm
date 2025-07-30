\set ON_ERROR_STOP 1

DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = {{ .Values.postgres.cwUser | squote }}) THEN
        ALTER USER {{ .Values.postgres.cwUser }} WITH PASSWORD {{ .Values.postgres.cwPassword | squote }};
    ELSE
        CREATE USER {{ .Values.postgres.cwUser }} WITH PASSWORD {{ .Values.postgres.cwPassword | squote }} NOINHERIT;
    END IF;
END $$;

SELECT 'CREATE DATABASE {{ .Values.postgres.cwDBName }}' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = {{ .Values.postgres.cwDBName | squote }})\gexec


REVOKE CONNECT ON DATABASE {{ .Values.postgres.cwDBName }} FROM PUBLIC;
GRANT CONNECT ON DATABASE {{ .Values.postgres.cwDBName }} TO {{ .Values.postgres.cwUser }};
GRANT ALL PRIVILEGES ON DATABASE {{ .Values.postgres.cwDBName }} TO {{ .Values.postgres.cwUser }};
\connect {{ .Values.postgres.cwDBName }};
GRANT ALL ON SCHEMA public TO {{ .Values.postgres.cwUser }};
