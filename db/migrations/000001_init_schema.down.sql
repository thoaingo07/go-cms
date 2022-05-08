drop table if exists public.user;
drop table if exists public.sys_tenant;
drop function nanoid(size int);
drop extension if exists pgcrypto;
drop extension if exists "uuid-ossp";