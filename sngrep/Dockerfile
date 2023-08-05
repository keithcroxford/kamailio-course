# vim:set ft=dockerfile:
FROM alpine:edge

RUN apk --update add sngrep ngrep bash \
&&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

ENTRYPOINT [ "tail","-f","/dev/null" ]
