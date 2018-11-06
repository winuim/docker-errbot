# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:alpine

# If you prefer miniconda:
#FROM continuumio/miniconda3

LABEL Name=docker-errbot Version=0.0.1
EXPOSE 3000

WORKDIR /app
ADD . /app

# Update & Install Requirments Packages.
RUN apk update && apk upgrade
RUN apk add tzdata vim bash gcc g++ libffi-dev openssl-dev git
RUN find . -type f -exec chmod -x {} \;

# Setup timezone
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN echo "Asia/Tokyo" > /etc/timezone

# Using pip:
RUN python3 -m pip install -r requirements.txt

# Setup errbot
RUN mkdir /app/errbot-root && cd /app/errbot-root && errbot --init

# Run
CMD ["sh", "run.sh"]
