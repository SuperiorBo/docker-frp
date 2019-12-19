# frps for Dockerfile
#frps_version=0.29.0
FROM alpine:latest
LABEL MAINTAINER=chobon@aliyun.com

ARG FRP_VERSION=0.29.0

# change ALIYUN apk source
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN set -ex \
    && apk add --no-cache pcre curl && \
    [ ! -d /usr/local/frps ] \
    && mkdir -p /usr/local/frps && cd /usr/local/frps

WORKDIR /tmp
RUN set -x \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -zxf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64 /var/local/frp \
    && mkdir -p /var/local/frps/conf \
    && apt remove -y wget \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /usr/local/frps/frps
ENTRYPOINT ["/entrypoint.sh"]