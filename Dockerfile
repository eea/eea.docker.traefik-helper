FROM debian:11-slim

RUN apt-get update -q \
 && apt-get install -y --no-install-recommends curl jq ca-certificates unzip git wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 


COPY docker-entrypoint.sh /
COPY prometheus.yml /
COPY grafanadashboard.json /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["run"]


