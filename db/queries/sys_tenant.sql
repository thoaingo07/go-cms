-- name: AddSysTenant :one
INSERT INTO sys_tenant(
	unique_id, handle_id, code, name, description, session_timeout, created_date, created_by, created_by_name, updated_date, updated_by, updated_by_name)
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING *;