ARG NGINX_VER

FROM wodby/php-nginx:${NGINX_VER}

USER root

RUN rm /etc/gotpl/default-vhost.conf.tpl

USER www-data

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/