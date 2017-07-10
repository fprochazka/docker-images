#!/bin/bash
#
# Run PHP in a container
#

set -e

VERSION="7.1"
IMAGE="fprochazka/php:$VERSION-exec"

DOCKER_VOLUMES="-v /home/fprochazka/devel:/home/fprochazka/devel"
DOCKER_ENVIRONMENT=""

# Setup volume mounts for compose config and context
if [ "$(pwd)" != '/' ]; then
    DOCKER_VOLUMES="$DOCKER_VOLUMES -v $(pwd):$(pwd)"
fi
if [ -n "$HOME" ]; then
    DOCKER_VOLUMES="$DOCKER_VOLUMES -v $HOME:$HOME"
    PHP_HOME="$HOME/.composer"
fi
if [ -n "$SSH_AUTH_SOCK" ]; then
	DOCKER_VOLUMES="$DOCKER_VOLUMES -v $SSH_AUTH_SOCK:/ssh-agent"
	DOCKER_ENVIRONMENT="$DOCKER_ENVIRONMENT -e SSH_AUTH_SOCK=/ssh-agent"
fi

if [[ -f "$1" || -d "$1" ]]; then
	ABS_ARG="$(cd $(dirname $1); pwd)/$(basename $1)"
    DOCKER_VOLUMES="$DOCKER_VOLUMES -v $ABS_ARG:$ABS_ARG"
fi

if [ -z "$PHP_USER_NAME" ]; then
	export PHP_USER_NAME=$(id -un)
fi
if [ -z "$PHP_USER_UID" ]; then
	export PHP_USER_UID=$(id -u)
fi
if [ -z "$PHP_USER_GID" ]; then
	export PHP_USER_GID=$(id -g)
fi

PHP_USER="-e PHP_USER_NAME -e PHP_USER_UID -e PHP_USER_GID -e PHP_HOME";

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

exec docker run --rm -u root $DOCKER_RUN_OPTIONS $DOCKER_VOLUMES $DOCKER_ENVIRONMENT $PHP_USER -w "$(pwd)" $IMAGE php "$@"
