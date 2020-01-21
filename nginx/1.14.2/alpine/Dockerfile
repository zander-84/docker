FROM alpine

MAINTAINER zander


#环境
ENV package_path /www/packages/
ENV source_path /www/server/source/
ENV server_path /www/server/
ENV data_path /www/data/
ENV config_path /www/data/config/


ENV NGINX_VERSION nginx-1.14.2
ENV NGINX_NAME nginx



RUN addgroup -g 82 -S www &&  adduser -u 82 -D  -S   -G www www && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
     apk update && \
     apk add --no-cache ca-certificates zlib openssl libxslt gd geoip pcre libzip libcurl&& \
     apk add --no-cache curl bash tree tzdata && \
     cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


#初始化目录
RUN  mkdir -pv ${package_path} && \
        mkdir -pv ${source_path} && \
        mkdir -pv ${server_path} && \
        mkdir -pv ${data_path} && \
        mkdir -pv ${config_path}



#编译
ADD nginx-1.14.2.tar.gz ${package_path}
RUN apk add --no-cache --virtual .build-deps \
                               gcc \
                               libc-dev \
                               make \
                               openssl-dev \
                               pcre-dev \
                               zlib-dev \
                               linux-headers \
                               libxslt-dev \
                               gd-dev \
                               geoip-dev \
                               perl-dev \
                               libedit-dev \
                               mercurial \
                               bash \
                               alpine-sdk \
                               findutils \
                               &&\
   cd ${package_path}${NGINX_VERSION} && \
        ./configure --prefix=${source_path}${NGINX_VERSION}  \
                    --conf-path=${source_path}${NGINX_VERSION}/conf/nginx.conf  \
                    --error-log-path=/var/log/nginx/error.log  \
                    --http-log-path=/var/log/nginx/access.log  \
                    --pid-path=/var/run/nginx.pid  \
                    --lock-path=/var/run/nginx.lock  \
                    --user=www  \
                    --group=www  \
                    --with-http_ssl_module  \
                    --with-http_v2_module  \
                    --with-http_dav_module  \
                    --with-http_stub_status_module  \
                    --with-threads  \
                    --with-file-aio  \
                    --with-http_gzip_static_module  \
                    --with-stream  \
                    &&  make -j "$(nproc)"  && make install && make clean && apk del --no-network .build-deps && rm -fr ${package_path}


#初始化
RUN ln -sv ${source_path}${NGINX_VERSION}  ${server_path}${NGINX_NAME} && \
    [ -d ${source_path}${NGINX_VERSION}/conf/conf.d/ ] || mkdir -pv ${source_path}${NGINX_VERSION}/conf/conf.d/ && \
    [ -d ${source_path}${NGINX_VERSION}/client_body_temp/ ] || mkdir -pv ${source_path}${NGINX_VERSION}/client_body_temp/ && \
    [ -d ${source_path}${NGINX_VERSION}/proxy_temp/ ] || mkdir -pv ${source_path}${NGINX_VERSION}/proxy_temp/ && \
    [ -d ${source_path}${NGINX_VERSION}/fastcgi_temp/ ] || mkdir -pv ${source_path}${NGINX_VERSION}/fastcgi_temp/ && \
    [ -d ${source_path}${NGINX_VERSION}/uwsgi_temp/ ] || mkdir -pv ${source_path}${NGINX_VERSION}/uwsgi_temp/ && \
    [ -d ${source_path}${NGINX_VERSION}/scgi_temp/ ] || mkdir -pv ${source_path}${NGINX_VERSION}/scgi_temp/ && \
    chmod -R a+w /var/log/nginx/ && \
    chmod -R a+w ${source_path}${NGINX_VERSION}/client_body_temp/  && \
    chmod -R a+w ${source_path}${NGINX_VERSION}/proxy_temp/  && \
    chmod -R a+w ${source_path}${NGINX_VERSION}/fastcgi_temp/ && \
    chmod -R a+w ${source_path}${NGINX_VERSION}/uwsgi_temp/ && \
    chmod -R a+w ${source_path}${NGINX_VERSION}/scgi_temp/ && \
    chown root ${server_path}${NGINX_NAME}/sbin/nginx && chmod u+s ${server_path}${NGINX_NAME}/sbin/nginx


ADD conf/nginx.conf  ${source_path}/${NGINX_VERSION}/conf/
ADD conf/conf.d/default.conf  ${source_path}/${NGINX_VERSION}/conf/conf.d/

EXPOSE 80 443

CMD ${server_path}${NGINX_NAME}/sbin/nginx -g 'daemon off;'




