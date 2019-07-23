#!/bin/sh

if [ ${ENV_PROD} = prod ]; then \
        cp -rf ${config_path}prod/php.ini ${source_path}${PHP_VERSION}/conf/; \
        cp -rf ${config_path}prod/www.conf ${source_path}${PHP_VERSION}/etc/php-fpm.d/; \
else \
        cp -rf ${config_path}dev/php.ini ${source_path}${PHP_VERSION}/conf/; \
        cp -rf ${config_path}dev/www.conf ${source_path}${PHP_VERSION}/etc/php-fpm.d/; \
fi

exec "$@"
