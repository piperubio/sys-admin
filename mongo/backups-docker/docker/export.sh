#!/bin/sh

echo "MONGO BACKUP started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)
DUMP_PATH="dumps/$MONGO_EXPORT_PREFIX-$DATE.json"

mongoexport -h "$MONGO_EXPORT_HOST" -d "$MONGO_EXPORT_DB" -u "$MONGO_EXPORT_USER" -p "$MONGO_EXPORT_PASSWORD" -c "$MONGO_EXPORT_COLLECTION" -o "$DUMP_PATH" --jsonArray

echo "MONGO BACKUP finished: $(date)"