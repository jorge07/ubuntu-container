FROM jorge07/ubuntu-php:7.0-dev

# Install base packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
      apache2 \
      libapache2-mod-php7.0 \

    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite expires headers

# Overwrite default Virtual Host
COPY config/apache/virtualhost.conf /etc/apache2/sites-enabled/000-default.conf
# Overwrite default php config
COPY config/php/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini

# Overwrite supervisor config
COPY config/supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 22 9000 80
