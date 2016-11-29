FROM jorge07/ubuntu:16.10

ENV DEBIAN_FRONTEND noninteractive

# Install base packages
RUN locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && export LC_ALL=en_US.UTF-8 \

    && add-apt-repository ppa:maxmind/ppa \
    && add-apt-repository ppa:ondrej/php \

    && apt-get update \
    && apt-get -yq --force-yes install \
      php7.0-curl \
      php7.0-mysql \
      php7.0-intl \
      php7.0-memcached \
      php7.0-memcache \
      php7.0-gd \
      php7.0-geoip \
      php7.0-intl \
      php7.0-ldap \
      php7.0-mcrypt \
      php7.0-readline \
      php7.0-xml \
      php7.0-mbstring \
      php7.0-zip \
      libmaxminddb0 \
      libmaxminddb-dev \
      net-tools \
      mmdb-bin \
      curl \
      git \
      zip \
      unzip \
    && rm -rf /var/lib/apt/lists/* \

    && phpenmod -v 7.0 mcrypt \

    && curl -O http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz \
    && gunzip GeoLite2-Country.mmdb.gz

