FROM wodby/nginx:1.10-2.1.0

ENV WODBY_DIR_FILES /mnt/files

RUN rm /etc/gotpl/default-vhost.conf.tpl && \
    mkdir -p $WODBY_DIR_FILES

COPY drupal.conf.tpl /etc/gotpl/
COPY init/* /docker-entrypoint-init.d/