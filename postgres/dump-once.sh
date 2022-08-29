while getopts h:p:U:d: option 
do
case "${option}" 
in
    h) HOST=${OPTARG};;
    p) PORT=${OPTARG};;
    U) USER=${OPTARG};;
    d) DATABASE=${OPTARG};;
esac
done

if [[ "$(docker images -q docker-pg_dump:latest)" == "" ]]; then
  docker build -t docker-pg_dump:latest .
fi

docker run -ti --rm \
    -v $(pwd)/dumps:/dumps \
    -e PREFIX=domergy-odoo \
    -e PGUSER=${USER} \
    -e PGDB=${DATABASE} \
    -e PGHOST=${HOST} \
    -e PGPORT=${PORT} \
    docker-pg_dump:latest dump