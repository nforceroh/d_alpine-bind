FROM nforceroh/d_alpine-s6:latest

LABEL maintainer="sylvain@nforcer.com"

ENV \ 
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8  \
    LANG=en_US.UTF-8  \
    LANGUAGE=en_US.UTF-8  \
    PUID=3000 \
	PGID=1000 \
	ENABLE_NFS=false 

RUN \
    mkdir -p /data/etc/bind /data/var/named \
    && ln -s /etc/bind /data/etc/bind \
    && ln -s /var/named /data/var/named \
    && apk add --no-cache bind bind-dnssec-tools \
    && rm -rf /var/cache/apk/*

COPY rootfs /
# ports and volumes
EXPOSE 53
WORKDIR /data/etc/bind
VOLUME /data
ENTRYPOINT [ "/init" ]