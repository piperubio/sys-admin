To create a dump just execute:

`$ ./dump-once.sh -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDB"`

To configure cron jobs:

1. Configure yours .env file
2. execute `$ docker-compose up -d`

> inspired by https://github.com/Annixa/docker-pg_dump
