FROM debian:bullseye

RUN apt-get update && \
    apt-get dist-upgrade && \
    apt-get install -y openssh-server ca-certificates curl gnupg && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian   bullseye stable" >> /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ssh/ssh_host_*

RUN mkdir /run/sshd

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
