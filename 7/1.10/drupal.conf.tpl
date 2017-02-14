server {
    server_name {{ getenv "NGINX_SERVER_NAME" "drupal" }};
    listen 80;

    root {{ getenv "NGINX_SERVER_ROOT" "/var/www/html/" }};
    index index.php;

    fastcgi_keep_conn on;
    fastcgi_index index.php;
    fastcgi_param QUERY_STRING $query_string;
    fastcgi_param SCRIPT_NAME $fastcgi_script_name;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_hide_header 'X-Drupal-Cache';
    fastcgi_hide_header 'X-Generator';

    location / {

        location ^~ /system/files/ {
            fastcgi_param QUERY_STRING q=$uri&$args;
            fastcgi_param SCRIPT_NAME /index.php;
            fastcgi_param SCRIPT_FILENAME $document_root/index.php;
            fastcgi_pass backend;
            log_not_found off;
        }

        location ^~ /sites/.*/files/private/ {
            internal;
        }

        location ~* /imagecache/ {
            access_log off;
            expires 30d;
            try_files $uri @drupal;
        }

        location ~* /files/styles/ {
            access_log off;
            expires 30d;
            try_files $uri @drupal;
        }

        location ~* ^/sites/.*/files/.*\.txt {
            expires 30d;
            tcp_nodelay off;
            open_file_cache max=3000 inactive=120s;
            open_file_cache_valid 45s;
            open_file_cache_min_uses 2;
            open_file_cache_errors off;
        }

        location ^~ /sites/.*/files/advagg_css/ {
            expires max;
            add_header ETag '';
            add_header Last-Modified 'Wed, 20 Jan 1988 04:20:42 GMT';
            add_header Accept-Ranges '';
            location ~* /sites/.*/files/advagg_css/css[_[:alnum:]]+\.css$ {
                access_log off;
                try_files $uri @drupal;
            }
        }

        location ^~ /sites/.*/files/advagg_js/ {
            expires max;
            add_header ETag '';
            add_header Last-Modified 'Wed, 20 Jan 1988 04:20:42 GMT';
            add_header Accept-Ranges '';
            location ~* /sites/.*/files/advagg_js/js[_[:alnum:]]+\.js$ {
                access_log off;
                try_files $uri @drupal;
            }
        }

        location ~* /admin/reports/hacked/.+/diff/ {
            try_files $uri @drupal;
        }

        location ~* ^.+\.(?:css|cur|js|jpe?g|gif|htc|ico|png|xml|otf|ttf|eot|woff|woff2|svg)$ {
            access_log off;
            expires 30d;
            tcp_nodelay off;
            open_file_cache {{ getenv "NGINX_STATIC_CONTENT_OPEN_FILE_CACHE" "max=3000 inactive=120s" }};
            open_file_cache_valid 45s;
            open_file_cache_min_uses 2;
            open_file_cache_errors off;
        }

        location ~* ^.+\.(?:pdf|pptx?)$ {
            expires 30d;
            tcp_nodelay off;
        }

        location ~* ^(?:.+\.(?:htaccess|make|txt|engine|inc|info|install|module|profile|po|pot|sh|.*sql|test|theme|tpl(?:\.php)?|xtmpl)|code-style\.pl|/Entries.*|/Repository|/Root|/Tag|/Template)$ {
            return 404;
        }
        try_files $uri @drupal;
    }

    location @drupal {
        include fastcgi_params;
        fastcgi_param QUERY_STRING $query_string;
        fastcgi_param SCRIPT_NAME /index.php;
        fastcgi_param SCRIPT_FILENAME $document_root/index.php;
        fastcgi_pass backend;
        track_uploads uploads 60s;
    }

    location @drupal-no-args {
        include fastcgi_params;
        fastcgi_param QUERY_STRING q=$uri;
        fastcgi_param SCRIPT_NAME /index.php;
        fastcgi_param SCRIPT_FILENAME $document_root/index.php;
        fastcgi_pass backend;
    }

    location = /index.php {
        fastcgi_pass backend;
    }

    location = /cron.php {
        fastcgi_pass backend;
    }

    location ~* ^/update.php {
        fastcgi_pass backend;
    }

    location = /install.php {
        fastcgi_pass backend;
    }

    location = /authorize.php {
        fastcgi_pass backend;
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
        access_log off;
        try_files $uri @drupal-no-args;
    }

    location = /rss.xml {
        try_files $uri @drupal-no-args;
    }

    location = /sitemap.xml {
        try_files $uri @drupal-no-args;
    }

    location = /favicon.ico {
        expires 30d;
        try_files /favicon.ico @empty;
    }

    location ~* ^/.well-known/ {
        allow all;
    }

    location @empty {
        expires 30d;
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
}
