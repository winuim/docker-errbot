# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:alpine AS build-env
WORKDIR /root
ADD . /root
RUN apk update && apk upgrade \
    && apk add gcc g++ libffi-dev openssl-dev \
    && python3 -m pip install -r requirements.txt --user


FROM python:alpine
COPY --from=build-env /root/.cache /root/.cache
COPY --from=build-env /root/.local /root/.local

WORKDIR /app
ADD . /app

# Update & Install Requirments Packages.
RUN apk add tzdata bash vim less git openssh-client \
    && find . -type f -exec chmod -x {} \; \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo "Asia/Tokyo" > /etc/timezone \
    && echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc \
    && source ~/.bashrc \
    && mkdir /app/errbot-root \
    && cd /app/errbot-root \
    && errbot --init

# Run
CMD ["sh", "run.sh"]
