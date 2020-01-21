#!/bin/sh


if [ ${ENV} = prod ]; then \
        cp -rf ${config_path}prod/php.ini ${source_path}${PHP_VERSION}/conf/; \
        cp -rf ${config_path}prod/www.conf ${source_path}${PHP_VERSION}/etc/php-fpm.d/; \
elif [ ${ENV} = dev ]; then\
        cp -rf ${config_path}dev/php.ini ${source_path}${PHP_VERSION}/conf/; \
        cp -rf ${config_path}dev/www.conf ${source_path}${PHP_VERSION}/etc/php-fpm.d/; \
fi

exec "$@"
