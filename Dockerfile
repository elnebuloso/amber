FROM elnebuloso/php:7.3-apache-ubuntu

COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY main /app
COPY VERSION /VERSION

ENV APP_NAME amber
ENV APP_TEXT_LEAD Simple Docker Placeholder Website

WORKDIR /app