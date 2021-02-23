FROM php:7.4-cli

RUN apt-get update
RUN apt-get install zip unzip git gzip -y
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY include_tmp/files/php.ini /usr/lib/php.ini
