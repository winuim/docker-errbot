#!/bin/sh

if [ -e /app/srv ]; then
  cp -r /app/srv/* /app/errbot-root/
fi

cd /app/errbot-root

while :
do
    case "$1" in
      -d | --debug)
      python3 /app/errbot-debug.py
      break
      ;;
      -*)
      echo "Error: Unknown option: $1" >&2
      exit 1
      ;;
      *)  # No more options
      errbot
      break
      ;;
    esac
done