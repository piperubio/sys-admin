#!/bin/bash

while getopts h:d:P:u:p:c: option 
do
    case "${option}" in
        h) MONGO_EXPORT_HOST=${OPTARG};;
        d) MONGO_EXPORT_DB=${OPTARG};;
        P) MONGO_EXPORT_PREFIX=${OPTARG};;
        u) MONGO_EXPORT_USER=${OPTARG};;
        p) MONGO_EXPORT_PASSWORD=${OPTARG};;
        c) MONGO_EXPORT_COLLECTION=${OPTARG};;
        *) 
    esac
done

if [[ "$(docker images -q mongodb-backups-docker:latest)" == "" ]]; then
  /bin/bash build.sh
fi

docker run -ti --rm \
    -v "$(pwd)"/dumps:/dumps \
    -e MONGO_EXPORT_HOST="${MONGO_EXPORT_HOST}" \
    -e MONGO_EXPORT_DB="${MONGO_EXPORT_DB}" \
    -e MONGO_EXPORT_PREFIX="${MONGO_EXPORT_PREFIX}" \
    -e MONGO_EXPORT_USER="${MONGO_EXPORT_USER}" \
    -e MONGO_EXPORT_PASSWORD="${MONGO_EXPORT_PASSWORD}" \
    -e MONGO_EXPORT_COLLECTION="${MONGO_EXPORT_COLLECTION}" \
    mongodb-backups-docker:latest export
