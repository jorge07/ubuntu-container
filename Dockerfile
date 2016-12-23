FROM jorge07/ubuntu:16.10

RUN apt-get update \
    && apt-get install -y curl build-essential \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y curl nodejs build-essential \
    && npm i -g yarn
    && rm -rf /var/lib/apt/lists/*
