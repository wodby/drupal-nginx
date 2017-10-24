upstream php {
    server {{ getenv "NGINX_BACKEND_HOST" }}:9000;
}

map $http_x_forwarded_proto $fastcgi_https {
    default $https;
    http '';
    https on;
}

server {
    server_name {{ getenv "NGINX_SERVER_NAME" "drupal" }};
    listen 80;

    root {{ getenv "NGINX_SERVER_ROOT" "/var/www/html/" }};
    index index.php;

    include fastcgi.conf;

{{ if getenv "NGINX_DRUPAL_HIDE_HEADERS" }}
    fastcgi_hide_header 'X-Drupal-Cache';
    fastcgi_hide_header 'X-Generator';
    fastcgi_hide_header 'X-Drupal-Dynamic-Cache';
{{ end }}

    location / {
{{ if getenv "NGINX_DRUPAL_FILE_PROXY_URL" }}
        location ~* /sites/.+/files {
            try_files $uri @file_proxy;
        }
{{ end }}
        location ~* /system/files/ {
            include fastcgi.conf;
            fastcgi_param QUERY_STRING q=$uri&$args;
            fastcgi_param SCRIPT_NAME /index.php;
            fastcgi_param SCRIPT_FILENAME $document_root/index.php;
            fastcgi_pass php;
            log_not_found off;
        }

        location ~* /sites/.+/files/private/ {
            internal;
        }

        location ~* /imagecache/ {
            access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
            expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
            try_files $uri @drupal;
        }

        location ~* /files/styles/ {
            access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
            expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
            try_files $uri @drupal;
        }

        location ~* /sites/.+/files/.+\.txt {
            access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
            expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
            tcp_nodelay off;
            open_file_cache {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE" "max=3000 inactive=120s" }};
            open_file_cache_valid {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_VALID" "45s" }};
            open_file_cache_min_uses {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_MIN_USES" "2" }};
            open_file_cache_errors off;
        }

        location ~* /sites/.+/files/advagg_css/ {
            expires max;
            add_header ETag '';
            add_header Last-Modified 'Wed, 20 Jan 1988 04:20:42 GMT';
            add_header Accept-Ranges '';
            location ~* /sites/.*/files/advagg_css/css[_[:alnum:]]+\.css$ {
                access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
                try_files $uri @drupal;
            }
        }

        location ~* /sites/.+/files/advagg_js/ {
            expires max;
            add_header ETag '';
            add_header Last-Modified 'Wed, 20 Jan 1988 04:20:42 GMT';
            add_header Accept-Ranges '';
            location ~* /sites/.*/files/advagg_js/js[_[:alnum:]]+\.js$ {
                access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
                try_files $uri @drupal;
            }
        }

        location ~* /admin/reports/hacked/.+/diff/ {
            try_files $uri @drupal;
        }
{{ if getenv "NGINX_ALLOW_XML_ENDPOINTS" }}
        location ~* ^.+\.xml {
            try_files $uri @drupal;
        }
{{ else }}
        location ~* /rss.xml {
            try_files $uri @drupal-no-args;
        }

        location ~* /sitemap.xml {
            try_files $uri @drupal;
        }
{{ end }}
        location ~* ^.+\.(?:css|cur|js|jpe?g|gif|htc|ico|png|xml|otf|ttf|eot|woff|woff2|svg|svgz)$ {
            access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
            expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
            tcp_nodelay off;
            open_file_cache {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE" "max=3000 inactive=120s" }};
            open_file_cache_valid {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_VALID" "45s" }};
            open_file_cache_min_uses {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE_MIN_USES" "2" }};
            open_file_cache_errors off;

            location ~* ^.+\.svgz$ {
                gzip off;
                add_header Content-Encoding gzip;
            }
        }

        location ~* ^.+\.(?:pdf|pptx?)$ {
            expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
            tcp_nodelay off;
        }

        location ~* ^(?:.+\.(?:htaccess|make|txt|engine|inc|info|install|module|profile|po|pot|sh|.*sql|test|theme|tpl(?:\.php)?|xtmpl)|code-style\.pl|/Entries.*|/Repository|/Root|/Tag|/Template)$ {
            return 404;
        }

        try_files $uri @drupal;
    }

{{ if getenv "NGINX_DRUPAL_FILE_PROXY_URL" }}
    location @file_proxy {
        rewrite ^ {{ getenv "NGINX_DRUPAL_FILE_PROXY_URL" }}$request_uri? permanent;
    }
{{ end }}

    location @drupal {
        include fastcgi.conf;
        fastcgi_param QUERY_STRING q=$no_slash_uri&$args;
        fastcgi_param SCRIPT_NAME /index.php;
        fastcgi_param SCRIPT_FILENAME $document_root/index.php;
        fastcgi_pass php;
        track_uploads {{ getenv "NGINX_DRUPAL_TRACK_UPLOADS" "uploads 60s" }};
    }

    location @drupal-no-args {
        include fastcgi.conf;
        fastcgi_param QUERY_STRING q=$no_slash_uri;
        fastcgi_param SCRIPT_NAME /index.php;
        fastcgi_param SCRIPT_FILENAME $document_root/index.php;
        fastcgi_pass php;
    }

    location ~* ^/authorize.php {
        include fastcgi.conf;
        fastcgi_param QUERY_STRING $args;
        fastcgi_param SCRIPT_NAME /authorize.php;
        fastcgi_param SCRIPT_FILENAME $document_root/authorize.php;
        fastcgi_pass php;
    }

    location = /cron.php {
        fastcgi_pass php;
    }

    location = /index.php {
        fastcgi_pass php;
    }

    location = /install.php {
        fastcgi_pass php;
    }

    location ~* ^/update.php {
        fastcgi_pass php;
    }

    location = /xmlrpc.php {
        {{ if getenv "NGINX_XMLRPC_SERVER_NAME" "" }}
        include fastcgi.conf;
        fastcgi_param  SERVER_NAME {{ getenv "NGINX_XMLRPC_SERVER_NAME" }};
        {{ end }}
        fastcgi_pass php;
    }

    location ^~ /.bzr {
        return 404;
    }

    location ^~ /.git {
        return 404;
    }

    location ^~ /.hg {
        return 404;
    }

    location ^~ /.svn {
        return 404;
    }

    location ^~ /.cvs {
        return 404;
    }

    location ^~ /patches {
        return 404;
    }

    location ^~ /backup {
        return 404;
    }

    location = /robots.txt {
        access_log {{ getenv "NGINX_STATIC_CONTENT_ACCESS_LOG" "off" }};
        try_files $uri @drupal-no-args;
    }

    location = /favicon.ico {
        expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
        try_files /favicon.ico @empty;
    }

    location ~* ^/.well-known/ {
        allow all;
    }

    location @empty {
        expires {{ getenv "NGINX_STATIC_CONTENT_EXPIRES" "30d" }};
        empty_gif;
    }

    location ~* ^.+\.php$ {
        return 404;
    }

    location ~ (?<upload_form_uri>.*)/x-progress-id:(?<upload_id>\d*) {
        rewrite ^ $upload_form_uri?X-Progress-ID=$upload_id;
    }

    location ~ ^/progress$ {
        upload_progress_json_output;
        report_uploads uploads;
    }

    include healthz.conf;
{{ if getenv "NGINX_SERVER_EXTRA_CONF_FILEPATH" }}
    include {{ getenv "NGINX_SERVER_EXTRA_CONF_FILEPATH" }};
{{ end }}
}
