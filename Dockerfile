FROM dobor/alpine-base:latest
LABEL MAINTAINER=chobon@aliyun.com

ARG FRP_VERSION=0.37.0

ENV FRP_MODE=frps

WORKDIR /tmp

RUN set -x && \
    apk add --update --no-cache curl && \
    curl -SL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz -O && \
    tar -zxf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
    mv frp_${FRP_VERSION}_linux_amd64/frpc /usr/bin/ && \
    mv frp_${FRP_VERSION}_linux_amd64/frps /usr/bin/ && \
    rm -rf frp_${FRP_VERSION}_linux_amd64 && \
    apk del curl && \
    rm -rf /var/cache/apk/*

# copy local files
ADD root /

#conf被配置成了卷，方便以后修改frps.ini
VOLUME /etc/frp

CMD []