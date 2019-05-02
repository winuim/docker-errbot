FROM python:alpine AS build-env
WORKDIR /root
COPY requirements.txt /root
# Update & Install Requirments Packages.
RUN apk update && apk add \
    gcc \
    libffi-dev \
    musl-dev \
    openssl-dev \
    tzdata \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo "Asia/Tokyo" > /etc/timezone \
    && python -m pip install -r requirements.txt


FROM python:alpine
LABEL maintainer="Yohei Uema <winuim@gmail.com>"
WORKDIR /app
COPY --from=build-env /etc/localtime /etc/localtime
COPY --from=build-env /etc/timezone /etc/timezone
COPY --from=build-env /usr/local/bin /usr/local/bin
COPY --from=build-env /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
COPY srv /app/srv
COPY entrypoint.sh /app/entrypoint.sh
RUN find /app -type f -exec chmod -x {} \;
RUN apk update && apk add \
    bash \
    shadow \
    && rm -rf /var/cache/apk/* \
    && groupadd -r errbot && useradd -m -r -g errbot errbot \
    && errbot --init \
    && chown -R errbot:errbot /app \
    && chmod +x entrypoint.sh

# Run
USER errbot
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "run" ]
