FROM redis
FROM mysql:5.7
FROM php:7.4.2-apache-buster


COPY sample.env .env
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update --fix-missing &&     apt-get upgrade -y &&     apt-get --no-install-recommends install -y apt-utils &&     rm -rf /var/lib/apt/lists/*


RUN apt-get -y update &&     apt-get -y --no-install-recommends install nano wget dialog libsqlite3-dev libsqlite3-0 &&     apt-get -y --no-install-recommends install default-mysql-client zlib1g-dev libzip-dev libicu-dev &&     apt-get -y --no-install-recommends install --fix-missing apt-utils build-essential git curl libonig-dev &&     apt-get -y --no-install-recommends install --fix-missing libcurl4 libcurl4-openssl-dev zip openssl &&     rm -rf /var/lib/apt/lists/* &&     curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN pecl install xdebug-2.8.0 &&     docker-php-ext-enable xdebug
RUN pecl install redis-5.1.1 &&     docker-php-ext-enable redis
RUN apt-get update &&     apt-get -y --no-install-recommends install --fix-missing libmagickwand-dev &&     rm -rf /var/lib/apt/lists/* &&     pecl install imagick &&     docker-php-ext-enable imagick
RUN docker-php-ext-install pdo_mysql &&     docker-php-ext-install pdo_sqlite &&     docker-php-ext-install mysqli &&     docker-php-ext-install curl &&     docker-php-ext-install tokenizer &&     docker-php-ext-install json &&     docker-php-ext-install zip &&     docker-php-ext-install -j$(nproc) intl &&     docker-php-ext-install mbstring &&     docker-php-ext-install gettext &&     docker-php-ext-install exif

RUN apt-get -y update &&     apt-get --no-install-recommends install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev &&     rm -rf /var/lib/apt/lists/* &&     docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg &&     docker-php-ext-install gdRUN a2enmod rewrite headers
RUN a2enmod rewrite headers
RUN rm -rf /usr/src/*
