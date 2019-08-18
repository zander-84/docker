FROM centos:7

MAINTAINER zander


#环境
ENV package_path /www/packages/
ENV source_path /www/server/source/
ENV server_path /www/server/
ENV data_path /www/data/
ENV config_path /www/data/config/

ENV PHP_VERSION php-7.3.7
ENV PHP_NAME php
ENV LIBZIP_VERSION libzip-1.2.0

#ENV ENV prod


#初始化目录
RUN  mkdir -pv ${package_path} && \
        mkdir -pv ${source_path} && \
        mkdir -pv ${server_path} && \
        mkdir -pv ${data_path} && \
        mkdir -pv ${config_path}

#依赖安装
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install epel-release && \
    yum install -y gcc gcc-c++ make perl-ExtUtils-MakeMaker  zlib zlib-devel pcre pcre-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel libcurl  curl curl-devel  openssl openssl-devel


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
    [ -d ${source_path}${PHP_VERSION}/conf ] || mkdir ${source_path}${PHP_VERSION}/conf && \
    [ -d ${source_path}${PHP_VERSION}/conf.d ] || mkdir ${source_path}${PHP_VERSION}/conf.d && \
    [ -f ${source_path}${PHP_VERSION}/conf/php.ini ] || cp ${package_path}${PHP_VERSION}/php.ini-production ${source_path}${PHP_VERSION}/conf/php.ini && \
    [ -f ${source_path}${PHP_VERSION}/conf/php.ini-development ] || cp ${package_path}${PHP_VERSION}/php.ini-development ${source_path}${PHP_VERSION}/conf/ && \
    [ -f ${source_path}${PHP_VERSION}/etc/php-fpm.conf ]  || cp  ${source_path}${PHP_VERSION}/etc/php-fpm.conf.default  ${source_path}${PHP_VERSION}/etc/php-fpm.conf && \
    [ -f ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf ] || cp ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf.default ${source_path}${PHP_VERSION}/etc/php-fpm.d/www.conf && \
    [ -f /usr/local/bin/php ] || ln -sv ${server_path}/${PHP_NAME}/bin/php /usr/local/bin/

COPY dev/php.ini ${config_path}dev/
COPY dev/www.conf ${config_path}dev/

COPY prod/php.ini ${config_path}prod/
COPY prod/www.conf ${config_path}prod/


RUN     chmod -R a+w  ${source_path}${PHP_VERSION}/var/log/ && \
        chmod -R a+w  ${source_path}${PHP_VERSION}/conf/ && \
        chmod -R a+w ${source_path}${PHP_VERSION}/etc/php-fpm.d/ && \
        yum clean all && rm -fr ${package_path}

EXPOSE 9000
CMD ${server_path}/${PHP_NAME}/sbin/php-fpm -F

RUN id www || useradd -r -M -s /sbin/nologin www || usermod -u 1000 www

ADD entrypoint.sh /bin/
ENTRYPOINT ["/bin/entrypoint.sh"]

