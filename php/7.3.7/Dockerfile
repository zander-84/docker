FROM centos:7

MAINTAINER zander


#环境
ENV package_path /www/packages/
ENV source_path /www/server/source/
ENV server_path /www/server/
ENV data_path /www/data/

ENV PHP_VERSION php-7.3.7
ENV PHP_NAME php
ENV LIBZIP_VERSION libzip-1.2.0


#初始化目录
RUN  mkdir -pv ${package_path} && \
        mkdir -pv ${source_path} && \
        mkdir -pv ${server_path} && \
        mkdir -pv ${data_path}

#依赖安装
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install epel-release && \
    yum -y groupinstall "Development tools" &&  \
    yum install  bash-completion libmcrypt freetype-devel libpng-devel gd-devel libcurl-devel libjpeg-turbo-devel libxslt-devel zlib-devel libxml2-devel libzip-devel libiconv-devel bzip2-devel libmcrypt-devel openssl openssl-devel

# libzip 依赖安装
ADD ${LIBZIP_VERSION}.tar.gz ${package_path}
RUN  yum remove libzip -y && cd ${package_path}${LIBZIP_VERSION} && ./configure  && make && make install && cp /usr/local/lib/libzip/include/zipconf.h /usr/local/include/zipconf.h



#php编译
ADD ${PHP_VERSION}.tar.gz ${package_path}
RUN cd ${package_path}${PHP_VERSION} && \
    ./configure --prefix=${source_path}${PHP_VERSION} \
    --enable-mysqlnd \
    --with-mysqli=mysqlnd \
    --with-openssl \
    --with-pdo-mysql=mysqlnd \
    --enable-mysqlnd \
    --enable-mbstring \
    --enable-bcmath \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib \
    --with-iconv \
    --enable-zip \
    --with-libxml-dir \
    --with-gd \
    --enable-xml \
    --enable-sockets \
    --enable-fpm \
    --with-config-file-path=${source_path}${PHP_VERSION}/conf  \
    --with-config-file-scan-dir=${source_path}${PHP_VERSION}/php.d  \
    --enable-maintainer-zts  \
    --enable-opcache  \
    --enable-session  \
    --with-curl  \
    --enable-maintainer-zts  \
    --enable-fileinfo \
    && make && make install

#初始化php
RUN ln -sv ${source_path}${PHP_VERSION}  ${server_path}/${PHP_NAME}   && \
    chmod -R a+w  ${source_path}${PHP_VERSION}/var/log/ && \
    [ -d ${source_path}${PHP_VERSION}/conf ] || mkdir ${source_path}${PHP_VERSION}/conf && \
    [ -d ${source_path}${PHP_VERSION}/conf.d ] || mkdir ${source_path}${PHP_VERSION}/conf.d && \
    [ -f ${source_path}${PHP_VERSION}/conf/php.ini ] || cp ${package_path}${PHP_VERSION}/php.ini-production ${source_path}${PHP_VERSION}/conf/php.ini && \
    [ -f ${source_path}${PHP_VERSION}/conf/php.ini-development ] || cp ${package_path}${PHP_VERSION}/php.ini-development ${source_path}${PHP_VERSION}/conf/ && \
    [ -f ${source_path}${PHP_VERSION}/etc/php-fpm.conf ]  || cp  ${source_path}${PHP_VERSION}/etc/php-fpm.conf.default  ${source_path}${PHP_VERSION}/etc/php-fpm.conf && \
    [ -f ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf ] || cp ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf.default ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf && \
    [ -f /usr/local/bin/php ] || ln -sv ${server_path}/${PHP_NAME}/bin/php /usr/local/bin/

COPY dev/php.ini ${package_path}dev/
COPY dev/www.conf ${package_path}dev/

COPY prod/php.ini ${package_path}prod/
COPY prod/www.conf ${package_path}prod/

ARG ENV_PROD=prod

RUN if [ ${ENV_PROD} = prod ]; then \
        cp -rf ${package_path}prod/php.ini ${source_path}${PHP_VERSION}/conf/; \
        cp -rf ${package_path}prod/www.conf ${source_path}${PHP_VERSION}/etc/php-fpm.d/; \
else \
        cp -rf ${package_path}dev/php.ini ${source_path}${PHP_VERSION}/conf/; \
        cp -rf ${package_path}dev/www.conf ${source_path}${PHP_VERSION}/etc/php-fpm.d/; \
fi

RUN yum clean all && rm -fr ${package_path}

EXPOSE 9000
CMD ${server_path}/${PHP_NAME}/sbin/php-fpm -F

