#!/bin/bash

while getopts h:d:u:p: option 
do
  case "${option}" in
      h) MONGO_RESTORE_HOST=${OPTARG};;
      d) MONGO_RESTORE_DB=${OPTARG};;
      u) MONGO_RESTORE_USER=${OPTARG};;
      p) MONGO_RESTORE_PASSWORD=${OPTARG};;
      *) 
  esac
done

shift $(($OPTIND - 1))
MONGO_RESTORE_PATH="$1"

if [[ "$(docker images -q mongodb-backups-docker:latest)" == "" ]]; then
  /bin/bash build.sh
fi

docker run -ti --rm \
    -v "$(pwd)"/dumps:/dumps \
    -e MONGO_RESTORE_HOST="${MONGO_RESTORE_HOST}" \
    -e MONGO_RESTORE_DB="${MONGO_RESTORE_DB}" \
    -e MONGO_RESTORE_USER="${MONGO_RESTORE_USER}" \
    -e MONGO_RESTORE_PASSWORD="${MONGO_RESTORE_PASSWORD}" \
    mongodb-backups-docker:latest restore