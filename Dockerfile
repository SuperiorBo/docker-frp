FROM alpine-base:latest
LABEL MAINTAINER=chobon@aliyun.com

ARG FRP_VERSION=0.29.0

RUN set -ex && \
    apk add --no-cache pcre curl && \
    [ ! -d /usr/local/frp ] && \
    mkdir -p /usr/local/frp && \
    cd /usr/local/frp

WORKDIR /tmp
RUN set -x && \
    curl -SL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz -O && \
    tar -zxf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
    mv frp_${FRP_VERSION}_linux_amd64 /var/local/frp && \
    mkdir -p /var/local/frp/conf && \
    apk del curl && \
    rm -rf /var/cache/apk/*

VOLUME /var/frp/conf    # conf被配置成了卷，方便以后修改frps.ini

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /usr/local/frp
ENTRYPOINT ["/entrypoint.sh"]