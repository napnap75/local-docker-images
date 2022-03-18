#!/bin/bash

set -e

VERSION=$(curl -s https://api.github.com/repos/the-djmaze/snappymail/releases/latest | jq -r '.name|ltrimstr("v")')
git clone -b v${VERSION} https://github.com/the-djmaze/snappymail
cd snappymail/.docker/release
curl -o snappymail.zip -L "https://api.github.com/repos/the-djmaze/snappymail/zipball/v${VERSION}"
sed -i "s/x86_64-linux-gnu/aarch64-linux-gnu/g" Dockerfile
docker build --build-arg FILES_ZIP=snappymail.zip -t napnap75/snappymail:${VERSION} .
cd ../../..
rm -fr snappymail
