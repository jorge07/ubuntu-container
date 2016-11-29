FROM ubuntu:yakkety

ENV TINI_VERSION v0.13.0

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/local/bin/tini

RUN chmod +x /usr/local/bin/tini \

    && apt-get update && apt-get install -y software-properties-common \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/tini", "--"]