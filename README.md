# Introduction
Headless Cms implement by Go (Gin framework) and postgres.
# Features
- Authentication with JWT.
- Allow upload zip file and custom domain.
# Migration
- Use https://github.com/golang-migrate/migrate
- Generate script:
` migrate create -ext sql -dir migrations -seq init_schema`
- Run migration:
Up
```
migrateup:
migrate -path migrations -database "postgresql://<user>:<pwd>@localhost:5432/cms?sslmode=disable" -verbose up
```
Down
```
migratedown:
migrate -path migrations -database "postgresql://<user>:<pwd>@localhost:5432/cms?sslmode=disable" -verbose down
```
Revert to a specific version
```
migrate -path migrations -database "postgresql://<user>:<pwd>@localhost:5432/cms?sslmode=disable" -verbose goto 1
```


