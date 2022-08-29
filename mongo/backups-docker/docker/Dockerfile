FROM alpine:latest

RUN apk add --no-cache mongodb-tools

VOLUME /data/db

ADD dump.sh /root
RUN chmod +x /root/dump.sh

ADD start.sh /root
RUN chmod +x /root/start.sh

ADD export.sh /root
RUN chmod +x /root/export.sh

ENTRYPOINT [ "/root/start.sh" ]
CMD [ "" ]