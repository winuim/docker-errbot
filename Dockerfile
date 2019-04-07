FROM python:alpine AS build-env
WORKDIR /root
COPY requirements.txt /root
RUN apk update && apk add \
    gcc \
    libffi-dev \
    musl-dev \
    openssl-dev \
    tzdata \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo "Asia/Tokyo" > /etc/timezone \
    && python3 -m pip install -r requirements.txt

FROM python:alpine
COPY --from=build-env /etc/localtime /etc/localtime
COPY --from=build-env /etc/timezone /etc/timezone
COPY --from=build-env /usr/local/bin /usr/local/bin
COPY --from=build-env /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
COPY srv /app/srv
RUN find /app -type f -exec chmod -x {} \;
# Update & Install Requirments Packages.
RUN apk update && apk add \
    bash \
    shadow \
    && rm -rf /var/cache/apk/* \
    && groupadd -r errbot && useradd -r -g errbot errbot \
    && chown -R errbot:errbot /app

USER errbot
WORKDIR /app
RUN errbot --init

ENV SLACK_BOT_TOKEN=""

# Run
CMD ["errbot", "-c", "srv/config.py"]
