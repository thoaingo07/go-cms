CREATE TABLE IF NOT EXISTS public.sys_tenant
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    unique_id uuid,
	handle_id varchar(50) not null,
    code character varying(250) COLLATE pg_catalog."default",
    api_key character varying(250) COLLATE pg_catalog."default",
    name character varying(500) COLLATE pg_catalog."default",
    description character varying(500) COLLATE pg_catalog."default",
    session_timeout integer,
    created_date timestamp without time zone,
    created_by integer,
    created_by_name character varying(250) COLLATE pg_catalog."default",
    updated_date timestamp without time zone,
    updated_by integer,
    updated_by_name character varying(250) COLLATE pg_catalog."default",
    CONSTRAINT sys_tenant_pkey PRIMARY KEY (id)
);
ALTER TABLE IF EXISTS public.sys_tenant
    OWNER TO cms_app;