#!/bin/bash
#
# Run composer in a container
#

set -e

VERSION="latest"
IMAGE="fprochazka/composer:$VERSION"

# Setup volume mounts for compose config and context
if [ "$(pwd)" != '/' ]; then
    VOLUMES="-v $(pwd):$(pwd)"
fi
if [ -n "$HOME" ]; then
    VOLUMES="$VOLUMES -v $HOME:$HOME"
    COMPOSER_HOME="$HOME/.composer"
fi

if [ -z "$COMPOSER_USER_NAME" ]; then
	export COMPOSER_USER_NAME=$(id -un)
fi
if [ -z "$COMPOSER_USER_UID" ]; then
	export COMPOSER_USER_UID=$(id -u)
fi
if [ -z "$COMPOSER_USER_GID" ]; then
	export COMPOSER_USER_GID=$(id -g)
fi

COMPOSER_USER="-e COMPOSER_USER_NAME -e COMPOSER_USER_UID -e COMPOSER_USER_GID -e COMPOSER_HOME";

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

exec docker run --rm $DOCKER_RUN_OPTIONS $VOLUMES $COMPOSER_USER -w "$(pwd)" $IMAGE "$@"
