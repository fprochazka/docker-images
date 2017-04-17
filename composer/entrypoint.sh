#!/bin/bash

set -e

if [ -z $(id "$COMPOSER_USER_NAME" >/dev/null 2>&1) ]; then
	groupadd --gid ${COMPOSER_USER_GID} ${COMPOSER_USER_NAME} >/dev/null 2>&1
	useradd --uid ${COMPOSER_USER_UID} --gid ${COMPOSER_USER_GID} --create-home ${COMPOSER_USER_NAME} >/dev/null 2>&1
fi

exec "gosu" $COMPOSER_USER_NAME /usr/local/bin/composer --ansi $@
