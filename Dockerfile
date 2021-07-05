FROM alpine-base:latest
LABEL MAINTAINER=chobon@aliyun.com

ARG FRP_VERSION=0.37.0

ENV FRP_DOMAIN=frp \
    FRP_DATA_DIR=/data/frp \
    FRP_CONFIG_DIR=/etc/frp/conf.d

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
#ENTRYPOINT ["/entrypoint.sh"]

CMD []