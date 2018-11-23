FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV LANG=en_US.UTF-8

WORKDIR /app
COPY . /app
RUN find . -type f -exec chmod -x {} \;

# Update & Install Requirments Packages.
RUN apt update && apt install -y \
    curl \
    git \
    locales \
    openssh-client \
    python3 \
    python3-setuptools \
    tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8 \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && python3 -m pip install -r requirements.txt \
    && rm -rf ~/.cache \
    && errbot --init

# Run
CMD ["bash", "run.sh"]
