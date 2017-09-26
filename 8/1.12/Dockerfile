FROM wodby/nginx:1.12

ENV WODBY_DIR_FILES="/mnt/files" \
    NGINX_CLIENT_MAX_BODY_SIZE="256m"

RUN rm /etc/gotpl/default-vhost.conf.tpl && \
    mkdir -p $WODBY_DIR_FILES

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/