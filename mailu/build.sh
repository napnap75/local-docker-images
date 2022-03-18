#!/bin/bash

set -e

VERSION=$(curl -s https://api.github.com/repos/Mailu/Mailu/releases/latest | jq -r '.name')
#curl -L "https://github.com/Mailu/Mailu/archive/refs/tags/${VERSION}.tar.gz" | tar zx
#env DOCKER_ORG=napnap75 DOCKER_PREFIX=mailu PINNED_MAILU_VERSION=${VERSION} docker-compose -f build.yml build
env VERSION=${VERSION} docker-compose -f build.yml build
#cd ../..
#rm -fr Mailu-${VERSION}
