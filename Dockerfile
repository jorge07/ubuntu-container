FROM jorge07/ubuntu-php:7.0

# Install base packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
      apache2 \
      libapache2-mod-php7.0 \

    && rm -rf /var/lib/apt/lists/*

# Overwrite default Virtual Host
COPY config/apache/virtualhost.conf /etc/apache2/sites-enabled/000-default.conf

# Overwrite supervisor config
COPY config/supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 80
