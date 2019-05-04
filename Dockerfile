FROM python:alpine
LABEL maintainer="Yohei Uema <winuim@gmail.com>"
WORKDIR /app
COPY . /app
# Install Requirments Packages.
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    libffi-dev \
    musl-dev \
    openssl-dev \
    && : Install pip packages \
    && python -m pip install -r requirements.txt \
    && : Delete build-deps packages \
    && apk del --purge .build-deps \
    && : Delete pip cache files \
    && rm -rf /root/.cache
# Install minimal Packages, and Setup App.
RUN apk add --no-cache \
    bash \
    shadow \
    tzdata \
    && : Setup timezone \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo "Asia/Tokyo" > /etc/timezone \
    && : Setup user \
    && groupadd -r errbot && useradd -m -r -g errbot errbot \
    && : Setup errbot \
    && errbot --init \
    && : Change owner and group \
    && chown -R errbot:errbot /app \
    && : Change permission  \
    && chmod +x entrypoint.sh

# Run
USER errbot
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "run" ]
