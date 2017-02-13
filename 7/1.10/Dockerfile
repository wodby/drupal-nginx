FROM wodby/nginx:1.10

RUN rm /etc/gotpl/default-vhost.conf.tpl

COPY drupal.conf.tpl /etc/gotpl/
COPY docker-entrypoint-drupal.sh /

ENTRYPOINT ["/docker-entrypoint-drupal.sh"]
