FROM php:7.0-fpm-alpine

MAINTAINER Bruno Paz <brunopaz@sapo.pt>

# alpine php already includes a www-data user, so its not needed to create
# we just create an unpriveledged user for our application. We set the 1000 id, so the permissions work
# when mounting the application volume. Need to investigate further to avoid this.
RUN addgroup app -g 1000 && adduser -u 1000 -D -G app app && addgroup app www-data

# For now we have to build and install php extensions from source, until alpine supports php7 in their sources.
# Some extensions like curl and mbstring are already installed in the base image.
RUN apk add --update curl freetype-dev libpng-dev libjpeg-turbo-dev libmcrypt-dev icu-dev autoconf g++ imagemagick-dev libtool make \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make \
    && rm -rf /tmp/* /var/cache/apk/*

# Add php configurations.
ADD etc/docker/php/php.ini /usr/local/etc/php
ADD etc/docker/php/symfony.pool.conf /usr/local/etc/php-fpm.d/

# Installs composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

## Install application (Note in dev environment you should use a volume mounted to this path instead
## See docker-compose.yml
RUN mkdir -p /var/www/app/
WORKDIR /var/www/app/

# The best practice would be to include composer.json and composer.lock first. Not working because of composer hooks.
COPY . ./

RUN chown -R app:app .
USER app

RUN composer install --no-interaction -o

CMD ["php-fpm", "-F"]

EXPOSE 9001

