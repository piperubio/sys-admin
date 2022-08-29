#!/bin/sh

set -e

COMMAND=${1:-dump}
#CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
#PREFIX=${PREFIX:-dump}
#PGUSER=${PGUSER:-influxdb}
#PGDB=${PGDB:-influxdb}
#PGHOST=${PGHOST:-domergy.cl}
#PGPORT=${PGPORT:-8086}


if [[ "$COMMAND" == 'dump' ]]; then
    exec /root/dump.sh
elif [[ "$COMMAND" == 'restore' ]]; then
    exec /root/restore.sh
elif [[ "$COMMAND" == 'export' ]]; then
    exec /root/export.sh
else
    echo "Unknown command $COMMAND"
    echo "Available commands: dump, dump-cron, restore, sync"
    exit 1
fi
