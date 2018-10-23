#!/bin/sh

if [ -e /app/srv ]; then
  cp -r /app/srv/* /app/errbot-root/
fi

cd /app/errbot-root
errbot
# python3 /app/errbot-debug.py
