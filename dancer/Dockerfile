FROM debian:bullseye

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y autossh uuid && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
