FROM alpine:latest

LABEL maintainer="forer@maple.cn"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update \
	&& apk add --no-cache --update python3 darkhttpd \
    && pip3 install --upgrade pip setuptools -i http://mirrors.aliyun.com/pypi/simple/ \
    && pip3 install -U https://github.com/JinnLynn/genpac/archive/master.zip \
    && mkdir -p /dist

COPY init.sh /init.sh

VOLUME ["/dist"]

EXPOSE 80

ENTRYPOINT ["/bin/sh", "/init.sh"]