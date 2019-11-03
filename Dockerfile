FROM elnebuloso/php:7.3-apache-ubuntu

COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY main /var/www/main
COPY VERSION /VERSION

WORKDIR /var/www/main