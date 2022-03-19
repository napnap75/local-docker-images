#!/bin/bash -e

if [ "$1" = "" ]; then
	VERSION=$(curl -s https://api.github.com/repos/Mailu/Mailu/releases/latest | jq -r '.name')
else
        VERSION=$1
fi
curl -L "https://github.com/Mailu/Mailu/archive/refs/tags/${VERSION}.tar.gz" | tar zx
env VERSION=${VERSION} docker-compose -f build.yml build
rm -fr Mailu-${VERSION}
