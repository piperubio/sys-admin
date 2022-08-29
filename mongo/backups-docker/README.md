# mongodb-backups-docker

### Build Image

1. chmod +x build.sh
2. ./build.sh

### Executar Backup una vez

executar `$ ./dump-once.sh -h HOST:PORT -d DATABASE_NAME -P PREFIX -u MONGO_USER -p MONGO_USER_PASSWORD`

cambiar los permisos de la carpeta generada por el dump \$ sudo chmod -R 777 PATH_FOLDER_DUMP

### Executar Export una vez

executar `$ ./export-once.sh -h HOST:PORT -d DATABASE_NAME -u MONGO_USER -p MONGO_USER_PASSWORD -P PREFIX -c MONGO_COLLECTION`

> Para exportar un JSON array agregar opción --jsonArray en export.sh
