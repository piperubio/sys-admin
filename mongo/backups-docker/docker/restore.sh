#!/bin/sh

echo "MONGO RESTORE started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)

mongorestore -h "$MONGO_RESTORE_HOST" -d "$MONGO_RESTORE_DB" -u "$MONGO_RESTORE_USER" -p "$MONGO_RESTORE_PASSWORD" -o "$MONGO_RESTORE_PATH"

echo "MONGO RESTORE finished: $(date)"