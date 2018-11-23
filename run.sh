#!/bin/sh

if [ -e /app/srv/plugins/ ]; then
  cp -r /app/srv/plugins/* /app/errbot-root/plugins/
fi

while :
do
    case "$1" in
      -d | --debug)
      python3 /app/errbot-debug.py -c /app/srv/config.py
      break
      ;;
      -*)
      echo "Error: Unknown option: $1" >&2
      exit 1
      ;;
      *)  # No more options
      errbot -c /app/srv/config.py
      break
      ;;
    esac
done