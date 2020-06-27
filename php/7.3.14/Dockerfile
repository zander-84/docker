FROM alpine

MAINTAINER zander


#环境
ENV package_path /www/packages/
ENV source_path /www/server/source/
ENV server_path /www/server/
ENV data_path /www/data/

ENV PHP_VERSION php-7.3.14
ENV PHP_NAME php
#ENV ENV prod
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c

RUN addgroup -g 82 -S www &&  adduser -u 82 -D  -S   -G www www


#初始化目录
RUN  mkdir -pv ${package_path} && \
        mkdir -pv ${source_path} && \
        mkdir -pv ${server_path} && \
        mkdir -pv /.composer/ && \
        mkdir -pv ${data_path} && \
        chown www:www  ${data_path} && \
        chmod 777 ${data_path} && chmod 777 /.composer

#依赖安装
RUN     sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
        apk add --no-cache \
		ca-certificates \
		curl \
		tar \
		xz \
# https://github.com/docker-library/php/issues/494
		openssl\
        zlib \
        pcre \
        libjpeg \
        libpng \
        freetype \
        libxml2 \
        glib  \
        bzip2 \
        libcurl \
        argon2-libs \
        git \
        libzip



#php编译
ADD ${PHP_VERSION}.tar.gz ${package_path}

RUN  apk update && apk add --no-cache --virtual .build-deps \
           $PHPIZE_DEPS \
           		argon2-dev \
           		coreutils \
           		curl-dev \
           		libedit-dev \
           		libsodium-dev \
           		libxml2-dev \
           		openssl-dev \
           		sqlite-dev \
           		 zlib-dev \
           		 pcre-dev \
           		 libjpeg-turbo-dev \
           		 libpng-dev \
           		 freetype-dev \
           		 glib-dev \
           		 bzip2-dev \
           		 libzip-dev \
           		 && \
    cd ${package_path}${PHP_VERSION} && \
    ./configure  \
        --prefix=${source_path}${PHP_VERSION} \
        --with-config-file-path=${source_path}${PHP_VERSION}/conf  \
        --with-config-file-scan-dir=${source_path}${PHP_VERSION}/php.d  \
        --enable-mysqlnd \
        --with-mysqli=mysqlnd \
        --enable-option-checking=fatal \
        --with-openssl \
        --with-pdo-mysql=mysqlnd \
        --enable-mysqlnd \
        --enable-mbstring \
        --enable-bcmath \
        --with-zlib \
        --with-iconv \
        --enable-zip \
        --with-gd \
        --with-png-dir \
        --with-jpeg-dir\
        --with-freetype-dir \
        --enable-xml \
        --enable-sockets \
        --enable-fpm \
        --enable-opcache  \
        --enable-session  \
        --with-curl  \
        --with-mhash  \
        --with-password-argon2 &&\
    make -j "$(nproc)" && \
    find -type f -name '*.a' -delete  && \
    find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true && \
     make install && make clean && apk del --no-network .build-deps

#初始化php
RUN ln -sv ${source_path}${PHP_VERSION}  ${server_path}/${PHP_NAME}   && \
    [ -d ${source_path}${PHP_VERSION}/conf ] || mkdir ${source_path}${PHP_VERSION}/conf && \
    [ -d ${source_path}${PHP_VERSION}/conf.d ] || mkdir ${source_path}${PHP_VERSION}/conf.d && \
    [ -f ${source_path}${PHP_VERSION}/conf/php.ini ] || cp ${package_path}${PHP_VERSION}/php.ini-production ${source_path}${PHP_VERSION}/conf/php.ini && \
    [ -f ${source_path}${PHP_VERSION}/conf/php.ini-development ] || cp ${package_path}${PHP_VERSION}/php.ini-development ${source_path}${PHP_VERSION}/conf/ && \
    [ -f ${source_path}${PHP_VERSION}/etc/php-fpm.conf ]  || cp  ${source_path}${PHP_VERSION}/etc/php-fpm.conf.default  ${source_path}${PHP_VERSION}/etc/php-fpm.conf && \
    [ -f ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf ] || cp ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf.default ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf && \
    [ -f /usr/local/bin/php ] || ln -sv ${server_path}/${PHP_NAME}/bin/php /usr/local/bin/



RUN     chmod -R a+w  ${source_path}${PHP_VERSION}/var/log/ && \
        chmod -R a+w  ${source_path}${PHP_VERSION}/conf/ && \
        chmod -R a+w ${source_path}${PHP_VERSION}/etc/php-fpm.d/ && \
        chmod -R a+w /tmp



#扩展安装
RUN apk add --no-cache --virtual .build-extend ${PHPIZE_DEPS}  && \
    ${source_path}${PHP_VERSION}/bin/pecl update-channels && \
    ${source_path}${PHP_VERSION}/bin/pecl install mongodb && \
    ${source_path}${PHP_VERSION}/bin/pecl install xdebug && \
    ${source_path}${PHP_VERSION}/bin/pecl install redis && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --quiet --install-dir=/usr/bin --filename=composer && \
    rm composer-setup.php && \
    apk del --no-network .build-extend



EXPOSE 9000


RUN rm -fr ${package_path}


WORKDIR ${data_path}

USER www

CMD ${server_path}/${PHP_NAME}/sbin/php-fpm -F

