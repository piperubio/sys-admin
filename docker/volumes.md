# Backup docker volume

docker run --rm --volumes-from CONTAINER_NAME -v $(pwd):/backup ubuntu tar cvf /backup/BACKUP_NAME.tar SOURCE_PATH

# Restore docker volume

 docker run --rm --volumes-from dbstore2 -v $(pwd):/backup ubuntu bash -c "cd /dbdata && tar xvf /backup/backup.tar --strip 1"

