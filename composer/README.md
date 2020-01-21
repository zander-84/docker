
#DOC
```https://hub.docker.com/_/composer

```

#CMD   注意$PWD
```
eval $(ssh-agent); \
docker run --rm -it \
--volume $SSH_AUTH_SOCK:/ssh-auth.sock \
--env SSH_AUTH_SOCK=/ssh-auth.sock \
--volume ${COMPOSER_HOME:-$HOME/.config/.composer}:/tmp \
--volume ${COMPOSER_CACHE_DIR:-$HOME/.config/.cache/composer}:$COMPOSER_CACHE_DIR \
--volume $PWD:/app \
composer update

```

#USER
```
--user $(id -u www) \
```
