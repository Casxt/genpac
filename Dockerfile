FROM python:2.7-alpine

LABEL maintainer="forer@maple.cn"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache darkhttpd \
    # && python3 -m pip install --upgrade pip setuptools -i http://mirrors.aliyun.com/pypi/simple/ \
    && pip install -U https://github.com/JinnLynn/genpac/archive/master.zip \
    && mkdir -p /dist

COPY init.sh /init.sh

VOLUME ["/dist"]

EXPOSE 80

ENTRYPOINT ["/bin/sh", "/init.sh"]