FROM debian:bullseye

RUN apt-get update && \
    apt-get dist-upgrade && \
    echo locales locales/locales_to_be_generated select "fr_FR.UTF-8 UTF-8" | debconf-set-selections && \
    echo locales locales/default_environment_locale select "fr_FR.UTF-8" | debconf-set-selections && \
    apt-get install -y zsh openssh-server ca-certificates curl gnupg gettext-base git locales netcat-openbsd && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian   bullseye stable" >> /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ssh/ssh_host_* && \
    mkdir /run/sshd

ENV LANG=fr_FR.UTF-8 LC_ALL=fr_FR.UTF-8


RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ADD entrypoint.sh invitation.template /
ADD zshrc /root/.zshrc
ADD dancer_completion /root/_dancer
ADD dockerparty.zsh-theme /root/.oh-my-zsh/themes/
ADD dancer.sh /usr/local/bin/dancer
ADD generate_test_data.sh /usr/local/bin/

ENTRYPOINT ["/entrypoint.sh"]
