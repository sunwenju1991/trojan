FROM debian:bullseye-slim

LABEL description="Debug image for running dockerized legacy trojan install script"

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    MYSQL_PORT=3307 \
    APP_PORT=443

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    openssl \
    socat \
    cron \
    procps \
    net-tools \
    netcat-openbsd \
    iputils-ping \
    dnsutils \
    iptables \
    iproute2 \
    gnupg \
    lsb-release \
    default-mysql-client \
    nginx \
    unzip \
    zip \
    tar \
    xz-utils \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/scripts /opt/app /usr/src/trojan-cert

COPY scripts/trojan_mult_docker.sh /opt/scripts/trojan_mult.sh
COPY scripts/tcp.sh /opt/scripts/tcp.sh
COPY scripts/entrypoint.sh /opt/scripts/entrypoint.sh

RUN chmod +x /opt/scripts/trojan_mult.sh \
    /opt/scripts/tcp.sh \
    /opt/scripts/entrypoint.sh

WORKDIR /opt/app

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/opt/scripts/entrypoint.sh"]
