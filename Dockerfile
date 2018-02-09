ARG BASE_IMAGE_TAG

FROM wodby/php-nginx:${BASE_IMAGE_TAG}

ARG DRUPAL_VER

ENV DRUPAL_VER="${DRUPAL_VER}"

USER root

RUN rm /etc/gotpl/default-vhost.conf.tpl

USER wodby

COPY templates /etc/gotpl/
COPY init /docker-entrypoint-init.d/