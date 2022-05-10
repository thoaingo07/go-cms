DB_URL=postgresql://cms_app:CmsStaticApp@192.168.1.40:5432/cms?sslmode=disable
network:
	docker network create bank-network

postgres:
	docker run --name postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=cms_app -e POSTGRES_PASSWORD=CmsStaticApp -d postgres:14-alpine
createdb:
	docker exec -it postgres createdb --username=cms_app --owner=root cms

migratedrop:
	migrate -path db/migrations -database "$(DB_URL)" -verbose drop

migrateup:
	migrate -path db/migrations -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migrations -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migrations -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migrations -database "$(DB_URL)" -verbose down 1
	
sqlc:
	sqlc generate
test:
	go test -v -cover ./...