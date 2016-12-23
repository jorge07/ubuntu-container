FROM jorge07/ubuntu:16.10

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs build-essential \
    && npm i -g yarn