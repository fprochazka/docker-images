#!/bin/bash
#
# Run composer in a container
#

set -e

VERSION="8.1"
IMAGE="fprochazka/node:$VERSION"

DOCKER_VOLUMES=""
DOCKER_ENVIRONMENT=""

# Setup volume mounts for compose config and context
if [ "$(pwd)" != '/' ]; then
    DOCKER_VOLUMES="$DOCKER_VOLUMES -v $(pwd):$(pwd)"
fi
if [ -n "$HOME" ]; then
    DOCKER_VOLUMES="$DOCKER_VOLUMES -v $HOME:$HOME"
fi
if [ -n "$SSH_AUTH_SOCK" ]; then
	DOCKER_VOLUMES="$DOCKER_VOLUMES -v $SSH_AUTH_SOCK:/ssh-agent"
	DOCKER_ENVIRONMENT="$DOCKER_ENVIRONMENT -e SSH_AUTH_SOCK=/ssh-agent"
fi

if [ -z "$NODE_USER_UID" ]; then
	export NODE_USER_UID=$(id -u)
fi
if [ -z "$NODE_USER_GID" ]; then
	export NODE_USER_GID=$(id -g)
fi

NODE_USER="-u $NODE_USER_UID:$NODE_USER_GID";

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

exec docker run --rm $DOCKER_RUN_OPTIONS $DOCKER_VOLUMES $DOCKER_ENVIRONMENT $NODE_USER -w "$(pwd)" $IMAGE "$@"
