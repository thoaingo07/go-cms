-- name: AddUser :one
INSERT INTO public.user(
	id, sys_tenant_id, unique_id, handle_id, first_name, last_name, is_active, email, phone, password, roles, last_accessed_at, created_date, created_by, created_by_name, updated_date, updated_by, updated_by_name)
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18)
RETURNING *;

-- name: GetUser :one
select * from public.user
where sys_tenant_id = $1 and id = $2 limit 1;

-- name: GetUsers :many
select * from public.user
where sys_tenant_id = $1
order by first_name, last_name
limit $2 offset $3;

-- name: UpdatePassword :exec
update public.user
set password = $1
where sys_tenant_id = $2 and id = $3;

-- name: DeleteUser :exec
delete from public.user
where sys_tenant_id = $1 and id = $2;
