#!/bin/bash

if [[ -e /app/srv/plugins/ ]]; then
  for dir_name in `ls -l /app/srv/plugins/ | awk '$1 ~ /d/ {print $9}'`; do
      if [[ -e /app/srv/plugins/$dir_name ]]; then
          if [[ ! -L /app/plugins/$dir_name ]]; then
              ln -s /app/srv/plugins/$dir_name /app/plugins/
          fi
      fi
  done
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