FROM debian:bullseye

RUN apt-get update && \
    apt-get dist-upgrade && \
    apt-get install -y autossh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["autossh", "-M", "0", "-N", "-o", "ServerAliveInterval 45", "-o", "ServerAliveCountMax 2", "-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null", "-i", "/id_rsa", "-R", "/var/run/docker.sock:/var/run/docker.sock"]
