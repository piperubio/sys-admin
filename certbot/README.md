Generate cert

'''bash
docker run -it --rm --name certbot \
 -v "${pwd}/etc/letsencrypt:/etc/letsencrypt" \
 -v "${pwd}/var/lib/letsencrypt:/var/lib/letsencrypt" \
 certbot/certbot certonly \
 --manual \
 --preferred-challenges=dns \
 --email soporte@vboost.cl \
 --server https://acme-v02.api.letsencrypt.org/directory \
 --agree-tos \
 -d *DOMAIN1*,*DOMAIN2*
'''

Install cert

Private key (*.key) -> privkey.pem
Cert (.crt) -> cert.pem
Cert CA (*-ca.crt) -> chain.pem
