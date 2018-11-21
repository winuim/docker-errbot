FROM ubuntu:latest AS build-env

WORKDIR /root
ADD . /root

RUN apt update && apt upgrade -y \
    && apt install python3-pip -y \
    && python3 -m pip install -r requirements.txt --user


FROM ubuntu:latest

COPY --from=build-env /root/.cache /root/.cache
COPY --from=build-env /root/.local /root/.local

WORKDIR /app
ADD . /app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV LC_ALL=en_US.UTF-8

# Update & Install Requirments Packages.
RUN apt update && apt upgrade -y \
    && apt install tzdata locales sudo curl openssh-client git python3 python3-setuptools python3-six python3-idna -y \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && find . -type f -exec chmod -x {} \; \
    && locale-gen en_US.UTF-8 \
    && echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc \
    && mkdir /app/errbot-root && cd /app/errbot-root && ~/.local/bin/errbot --init \
    && curl https://krypt.co/kr | sh

# Run
CMD ["sh", "run.sh"]
