#!/bin/bash

while getopts h:d:P:u:p: option 
do
    case "${option}" in
        h) MONGO_DUMP_HOST=${OPTARG};;
        d) MONGO_DUMP_DB=${OPTARG};;
        P) MONGO_DUMP_PREFIX=${OPTARG};;
        u) MONGO_DUMP_USER=${OPTARG};;
        p) MONGO_DUMP_PASSWORD=${OPTARG};;
        *) 
    esac
done

if [[ "$(docker images -q mongodb-backups-docker:latest)" == "" ]]; then
  /bin/bash build.sh
fi

docker run -ti --rm \
    -v "$(pwd)"/dumps:/dumps \
    -e MONGO_DUMP_HOST="${MONGO_DUMP_HOST}" \
    -e MONGO_DUMP_DB="${MONGO_DUMP_DB}" \
    -e MONGO_DUMP_PREFIX="${MONGO_DUMP_PREFIX}" \
    -e MONGO_DUMP_USER="${MONGO_DUMP_USER}" \
    -e MONGO_DUMP_PASSWORD="${MONGO_DUMP_PASSWORD}" \
    mongodb-backups-docker:latest dump
