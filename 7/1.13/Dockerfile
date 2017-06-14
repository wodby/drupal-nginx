FROM wodby/nginx:1.13-2.4.0

ENV WODBY_DIR_FILES /mnt/files

RUN rm /etc/gotpl/default-vhost.conf.tpl && \
    mkdir -p $WODBY_DIR_FILES

COPY drupal.conf.tpl /etc/gotpl/
COPY init/* /docker-entrypoint-init.d/