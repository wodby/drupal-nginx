FROM wodby/nginx:1.10

RUN rm /etc/gotpl/default-vhost.conf.tpl

COPY drupal.conf.tpl /etc/gotpl/
COPY init/* /docker-entrypoint-init.d/