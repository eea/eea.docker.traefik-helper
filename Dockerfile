FROM debian:10-slim

RUN apt-get update -q \
 && apt-get install -y --no-install-recommends ca-certificates unzip git wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 


COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["run"]


