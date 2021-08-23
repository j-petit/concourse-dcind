FROM alpine:3

ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=20.10.7 \
    DOCKER_COMPOSE_VERSION=1.29.2 \
    DOCKER_SQUASH=0.2.0

# Install Docker and Docker Compose
RUN apk --no-cache add \
    bash \
    curl \
    util-linux \
    device-mapper \
    libffi-dev \
    openssl-dev \
    py3-pip \
    python3-dev \
    gcc \
    libc-dev \
    make \
    rust \
    cargo \
    iptables

# Install Docker, Docker Compose, Docker Squash
RUN curl -fL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" | tar zx && \
    mv /docker/* /bin/ && chmod +x /bin/docker* && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache

COPY entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
