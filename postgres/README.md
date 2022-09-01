# Docker PG Dump

To create a dump just execute:

`$ ./dump-once.sh -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDB"`

To configure cron jobs:

1. Configure yours .env file
2. execute `$ docker-compose up -d`

> inspired by https://github.com/Annixa/docker-pg_dump


# Docker one liner

## Backup

docker exec -i CONTAINER_ID|CONTAINER_NAME /usr/bin/pg_dump -U USER DATABASE > DATABASE_dump_$(date +%d-%m-%Y"_"%H_%M_%S).sql

## Backup with gzip

docker exec -i CONTAINER_ID|CONTAINER_NAME /usr/bin/pg_dump -U USER DATABASE | gzip -9 DATABASE_dump_$(date +%d-%m-%Y"_"%H_%M_%S).sql.gz

## Restore

cat your_dump.sql | docker exec -i your-db-container psql -U postgres

