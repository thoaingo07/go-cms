alter role cms_app with superuser;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
create extension if not exists pgcrypto;
CREATE OR REPLACE FUNCTION nanoid(size int DEFAULT 12)
RETURNS text AS $$
DECLARE
  id text := '';
  i int := 0;
  urlAlphabet char(64) := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz-';
  bytes bytea := gen_random_bytes(size);
  byte int;
  pos int;
BEGIN
  WHILE i < size LOOP
    byte := get_byte(bytes, i);
    pos := (byte & 63) + 1; -- + 1 because substr starts at 1 for some reason
    id := id || substr(urlAlphabet, pos, 1);
    i = i + 1;
  END LOOP;
  RETURN id;
END
$$ LANGUAGE PLPGSQL STABLE;

ALTER FUNCTION nanoid(size int) OWNER TO cms_app;
CREATE TABLE IF NOT EXISTS public.sys_tenant
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    unique_id uuid default gen_random_uuid(),
	  handle_id varchar(50) not null default nanoid(),
    code varchar(250),
    name varchar(500),
    description varchar(500),
    session_timeout integer,
    created_date timestamptz default now(),
    created_by integer,
    created_by_name varchar(250),
    updated_date timestamptz default now(),
    updated_by integer,
    updated_by_name varchar(250),
    CONSTRAINT sys_tenant_pkey PRIMARY KEY (id)
);
ALTER TABLE IF EXISTS public.sys_tenant OWNER TO cms_app;

CREATE TABLE IF NOT EXISTS public.user
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    sys_tenant_id integer NOT NULL,
    unique_id uuid default gen_random_uuid(),
	  handle_id varchar(50) default nanoid(),
    first_name varchar(250),
    last_name varchar(250),
    is_active boolean,
    email varchar(250),
    phone varchar(250),
    password varchar,
    roles varchar[],
    last_accessed_at timestamptz,
    created_date timestamptz default now(),
    created_by integer,
    created_by_name varchar(250),
    updated_date timestamptz default now(),
    updated_by integer,
    updated_by_name varchar(250),
    CONSTRAINT user_pkey PRIMARY KEY (id)
);
ALTER TABLE IF EXISTS public.user OWNER TO cms_app;
ALTER TABLE IF EXISTS public."user"
    ADD CONSTRAINT sys_tenant_id_fkey FOREIGN KEY (sys_tenant_id)
    REFERENCES public.sys_tenant (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
