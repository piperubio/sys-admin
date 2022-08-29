FROM postgres:alpine

ADD dump.sh /dump.sh
RUN chmod +x /dump.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /dumps

ENTRYPOINT ["/start.sh"]
CMD [""]