#!/bin/sh

echo "MONGO DUMP started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)
DUMP_PATH="dumps/$MONGO_DUMP_PREFIX-$DATE"

mongodump -h "$MONGO_DUMP_HOST" -d "$MONGO_DUMP_DB" -u "$MONGO_DUMP_USER" -p "$MONGO_DUMP_PASSWORD" -o "$DUMP_PATH"

echo "MONGO DUMP finished: $(date)"