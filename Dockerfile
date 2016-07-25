FROM alpine:3.4
MAINTAINER Wodby <hello@wodby.com>

ENV NGX_VER 1.10.1
ENV NGX_UP_VER 0.9.1
ENV NGX_LUA_VER 0.10.5
ENV NGX_NDK_VER 0.3.0
ENV NGX_NXS_VER 0.54
ENV LUAJIT_LIB /usr/lib/
ENV LUAJIT_INC /usr/include/luajit-2.0/

# Create user and groups
# Based on http://git.alpinelinux.org/cgit/aports/tree/main/nginx-initscripts/nginx-initscripts.pre-install
RUN addgroup -S -g 82 www-data && \
    addgroup -S nginx && \
    adduser -S -D -H -h /var/www/localhost/htdocs -s /sbin/nologin -G nginx -g nginx nginx && \
    addgroup nginx www-data

# Install packages
RUN apk add --update \

        # Base packages
        openssl \
        ca-certificates \
        pcre \
        zlib \
        luajit \
        geoip \
        tar \
        libcrypto1.0 \
        libssl1.0 \

        # Temp packages
        tar \
        build-base \
        autoconf \
        libtool \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        luajit-dev \
        geoip-dev && \

    # Download nginx and its modules source code
    wget -qO- http://nginx.org/download/nginx-${NGX_VER}.tar.gz | tar xz -C /tmp/ && \
    wget -qO- https://github.com/simpl/ngx_devel_kit/archive/v${NGX_NDK_VER}.tar.gz | tar xz -C /tmp/ && \
    wget -qO- https://github.com/masterzen/nginx-upload-progress-module/archive/v${NGX_UP_VER}.tar.gz | tar xz -C /tmp/ && \
    wget -qO- https://github.com/openresty/lua-nginx-module/archive/v${NGX_LUA_VER}.tar.gz | tar xz -C /tmp/ && \
    wget -qO- https://github.com/nbs-system/naxsi/archive/${NGX_NXS_VER}.tar.gz | tar xz -C /tmp/ && \

    # Make and install nginx with modules
    cd /tmp/nginx-${NGX_VER} && \
    ./configure \
        --prefix=/usr/share/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx/nginx.pid \
        --lock-path=/var/run/nginx/nginx.lock \
        --http-client-body-temp-path=/var/lib/nginx/tmp/client_body \
        --http-proxy-temp-path=/var/lib/nginx/tmp/proxy \
        --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi \
        --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi \
        --http-scgi-temp-path=/var/lib/nginx/tmp/scgi \
        --user=nginx \
        --group=nginx \
        --with-pcre-jit \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-http_v2_module \
        --with-ipv6 \
        --with-threads \
        --with-stream \
        --with-stream_ssl_module \
        --with-http_geoip_module \
        --with-ld-opt="-Wl,-rpath,/usr/lib/" \
        --add-module=/tmp/ngx_devel_kit-${NGX_NDK_VER}/ \
        --add-module=/tmp/nginx-upload-progress-module-${NGX_UP_VER}/ \
        --add-module=/tmp/lua-nginx-module-${NGX_LUA_VER}/ \
        --add-module=/tmp/naxsi-${NGX_NXS_VER}/naxsi_src/ && \
    make -j2 && \
    make install && \

    # Cleanup
    apk del --purge *-dev build-base autoconf libtool && \
    rm -rf /var/cache/apk/* /tmp/*

# Create dirs
RUN mkdir /etc/nginx/conf.d && \
    mkdir -p /var/lib/nginx/tmp && \
    chmod 755 /var/lib/nginx && \
    chmod -R 755 /var/lib/nginx/tmp && \
    mkdir -p /etc/nginx/pki && \
    chmod 400 /etc/nginx/pki

# Copy configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY fastcgi_params /etc/nginx/fastcgi_params
COPY drupal* /opt/

WORKDIR /var/www/html
VOLUME /var/www/html

EXPOSE 80 443

COPY docker-entrypoint.sh /usr/local/bin/
CMD "docker-entrypoint.sh"
