#!/bin/bash -e
if [ "$1" = "" ]; then
	VERSION=$(curl -s https://api.github.com/repos/the-djmaze/snappymail/releases/latest | jq -r '.name|ltrimstr("v")')
else
	VERSION=$1
fi
curl -o snappymail-${VERSION}.zip -L "https://api.github.com/repos/the-djmaze/snappymail/zipball/v${VERSION}"
unzip snappymail-${VERSION}.zip
mv snappymail-${VERSION}.zip the-djmaze-snappymail-*/.docker/release
cd the-djmaze-snappymail-*/.docker/release
curl -o snappymail-${VERSION}.zip -L "https://github.com/the-djmaze/snappymail/releases/download/v${VERSION}/snappymail-${VERSION}.zip"
sed -i "s/x86_64-linux-gnu/aarch64-linux-gnu/g" Dockerfile
docker build --no-cache --build-arg FILES_ZIP=snappymail-${VERSION}.zip -t napnap75/snappymail:${VERSION} .
cd ../../..
rm -fr the-djmaze-snappymail-*
