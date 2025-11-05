#!/bin/bash
set -e

SPC_URL="https://dl.static-php.dev/static-php-cli/spc-bin/nightly/spc-linux-x86_64"
SPC_FILE="./spc"
PHP_SERVER_BIN="./runtimes/php-server/php"
WEBMAN_BIN="./runtimes/webman/build/php8.4.micro.sfx"
WORKERMAN_BIN="./runtimes/workerman_sf/bin/php"

if [ -f "$SPC_FILE" ]; then
    echo "File 'spc' already exists."
else
    echo "Downloading 'spc'..."
    curl -# -fSL -o "$SPC_FILE" "$SPC_URL"
fi

if [ ! -x "$SPC_FILE" ]; then
    echo "Making 'spc' executable..."
    chmod +x "$SPC_FILE"
fi

if [ ! -f "$PHP_SERVER_BIN" ]; then
    "$SPC_FILE" craft runtimes/php-server/craft.yml
    echo "Coping php binary to php-server directory"
    cp buildroot/bin/php "$PHP_SERVER_BIN"
fi

docker build runtimes/php-server --tag crazygoat/tinyphp

if [ ! -f "$WEBMAN_BIN" ]; then
    "$SPC_FILE" craft runtimes/webman/craft.yml
    echo "Coping php binary to php-server directory"
    mkdir -p runtimes/webman/build
    cp buildroot/bin/micro.sfx "$WEBMAN_BIN"
fi

cd runtimes/webman && composer i --no-dev && php -d phar.readonly=0 ./webman build:bin && cd ../..

if [ ! -f "$WORKERMAN_BIN" ]; then
    "$SPC_FILE" craft runtimes/workerman_sf/craft.yml
    echo "Coping php binary to php-server directory"
    cp buildroot/bin/php "$WORKERMAN_BIN"
fi

cd runtimes/workerman_sf && composer i --no-dev && cd ../..

docker build runtimes/php-server --tag crazygoat/tinyphp:latest
docker build runtimes/php-server --tag crazygoat/tinyphp:php-server
docker build runtimes/webman --tag crazygoat/tinyphp:webman
docker build runtimes/workerman_sf --tag crazygoat/tinyphp:symfony
