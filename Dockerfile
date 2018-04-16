FROM php:7.1-apache

LABEL maintainer="Luiz Eduardo <luiz@powertic.com>"

# Install PHP extensions
RUN apt-get update && apt-get install --no-install-recommends -y \
      libicu-dev \
      cron \
      libc-client-dev \
      libicu-dev \
      libkrb5-dev \
      libmcrypt-dev \
      libpq-dev \
      libssl-dev \
      git \
      zip \
      unzip \
      wget \
      curl \
      libmcrypt-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install \
      intl \
      mbstring \
      mcrypt \
      pcntl \
      pdo_mysql \
      pdo_pgsql \
      pgsql \
      zip \
      opcache \
      && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
      && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Put apache config for Laravel
COPY docker-apache/apache2-laravel.conf /etc/apache2/sites-available/laravel.conf

RUN a2dissite 000-default.conf && a2ensite laravel.conf && a2enmod rewrite

VOLUME /var/www/html

WORKDIR /var/www/html

COPY docker-apache/docker-php-entrypoint /usr/local/bin/

EXPOSE 80

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]
