FROM jorge07/ubuntu-php:7.0

ENV NOTVISIBLE="in users profile"

ARG SSH_USER=root
ARG SSH_PASS=root

# Install base packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
      openssh-server \
      supervisor \
      git \
      ant \
      php7.0-fpm \
      php7.0-xdebug \

    && rm -rf /var/lib/apt/lists/* \

    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require "hirak/prestissimo:^0.3" \

    # Install phpunit
    && wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/bin/phpunit \

    # Install Psy, a debug tool
    && wget https://git.io/psysh \
    && chmod +x psysh \
    && mv psysh /usr/bin/psysh \

    # Install SSH Server to connect with your favourite IDE
    && mkdir -p /var/run/sshd \
    && echo "${SSH_USER}:${SSH_PASS}" | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \

    # SSH login fix. Otherwise user is kicked off after login
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

COPY config/supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/php/php.ini /etc/php/7.0/cli/conf.d/50-settings.ini
COPY config/php/xdebug.ini /tmp/20-xdebug.ini
COPY config/env/aliases /root/.bash_aliases

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 22 9000
