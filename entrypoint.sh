#!/bin/sh

if [ -z "$S3S_CONFIG" ]; then
  printf "[!] The environment variable S3S_CONFIG is missing, so the program will interact you to know the credentials.\n\n"
fi

echo $S3S_CONFIG > config.txt

exec "$@"
