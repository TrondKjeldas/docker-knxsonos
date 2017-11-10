##
## knxsonos
##

## Use latest Alpine based images as starting point
FROM python:2.7-alpine

# Select branch
ARG BRANCH=master

COPY entrypoint.sh /

RUN apk add --no-cache git  \
    && git clone https://github.com/TrondKjeldas/knxsonos.git --single-branch --branch $BRANCH \
    && cd knxsonos \
    && python setup.py build \
    && python setup.py install \
    && addgroup -S knxsonos \
    && adduser -D -S -s /sbin/nologin -G knxsonos knxsonos \
    && chmod a+x /entrypoint.sh \
    && apk del --no-cache git

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-c /etc/knxsonos/knxsonos.config"]
