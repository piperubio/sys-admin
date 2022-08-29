### Nginx Reverse Proxy

#### Run

$ docker run --name Domergy-proxy -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro -p 80:80 -d nginx



### Generar certificados SSL para Domergy

1) Crear un nuevo dir en el servidor: "nginx-proxy-letsencrypt"

2) Ingresar al nuevo dir: cd nginx-proxy-letsencrypt

3) Crer nuevo dir e ingresar  

    $ sudo mkdir -p ${pwd}/letsencrypt-site
    $ cd letsencrypt-site

4) Copiar archivo index.html en el servidor, espesificiamente en el dir creado anteriormente "letsencrypt-site"

5) Copiar en el dir "nginx-proxy-letsencrypt" el archivo docker-compose-gen y generar container simple de nginx a traves de el siguiente comando

  $ docker-compose -f docker-compose-gen.yml up -d

6) Ingresar a domergy.cl y verificar si el dominio se encuentra arriba, si es asi continuar si no verificar pasos anteriores

7) Generar certificados SSL para todos los dominios espesificados en el archivo "default.conf" con el siguiente comando:

    sudo docker run -it --rm \
    -v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
    -v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
    -v /home/krouw/produccion/nginx-proxy-letsencrypt/letsencrypt-site:/data/letsencrypt \
    -v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
    certbot/certbot \
    certonly --webroot \
    --email contacto@domergy.cl --agree-tos --no-eff-email \
    --webroot-path=/data/letsencrypt \
    -d domergy.cl -d www.domergy.cl -d app.domergy.cl -d odoo.domergy.cl -d grafana.domergy.cl -d chronograf.domergy.cl -d cadvisor.domergy.cl -d jenkins.domergy.cl -d backend.domergy.cl -d influx.domergy.cl -d broker.domergy.cl

8) Obtener informacion adicional de los certificados generados para el dominio de domergy

    sudo docker run --rm -it --name certbot \
    -v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
    -v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
    -v /home/krouw/produccion/nginx-proxy-letsencrypt/letsencrypt-site:/data/letsencrypt \
    certbot/certbot \
    --staging \
    certificates

9) Si todo salio correctamente hasta el paso anterior, detener temporalmente el contenedor docker de nginx con el siguiente comando

  $ docker-compose -f docker-compose-gen.yml down

10) copiar en el directorio "nginx-proxy-letsencrypt" (creado en el paso 1) los archivos "nginx.conf" y "docker-compose.yml"

11) Crear un nuevo directorio llamado "dh-param" en "nginx-proxy-letsencrypt" y ejecutar los siguientes comandos para generar 2048 bit DH param file

  $ cd dh-param
  $ sudo openssl dhparam -out dhparam-2048.pem 2048

12) Ejecutar un nuevo contenedor con la configuracion para produccion

  $ docker-compose up -d

13) Hasta este punto, los certificados deberian estar funcionando en los dominios. Verificar ingresando a domergy.cl

14) Renovar automaticamente los certificados SLL/TLS, pogramando una funcion crontab que se ejecuta diariamente a las 23hrs, ejecutando el siguiente comando

  $ sudo crontab -e
  $ 0 23 * * *
  sudo docker run --rm -it --name certbot \
  -v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
  -v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
  -v /docker-volumes/data/letsencrypt:/data/letsencrypt \
  -v /docker-volumes/var/log/letsencrypt:/var/log/letsencrypt \
  certbot/certbot \
  renew \
  --webroot --webroot-path=/data/letsencrypt
  && docker kill --signal=SIGHUP production-nginx-container

***Nota: de momento no funciona el paso 14
