FROM php:apache
RUN apt-get update
RUN apt-get install -y libmcrypt-dev git zip unzip libmagickwand-dev --no-install-recommends
#RUN apt-get install -y apache2
RUN pecl install imagick \
RUN docker-php-ext-enable imagick

#RUN apachectl start
#RUN apt-get install -y install libapache2-mod-php7.3

RUN rm -rf /var/www/html
RUN git clone https://github.com/SiamandMaroufi/escpos-tools.git /var/www/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


WORKDIR /var/www/html
RUN composer install

COPY index.php /var/www/html/index.php
COPY esc.php /var/www/html/esc.php

RUN echo 'echo $1 | base64 --decode > decoded.txt ; php /var/www/html/esc2text.php decoded.txt > /var/www/html/paper.html' > /usr/bin/text
RUN echo 'echo $1 | base64 --decode > decoded.txt ; php /var/www/html/esc2html.php decoded.txt > /var/www/html/paper.html' > /usr/bin/html

RUN chmod +x /usr/bin/text
RUN chmod +x /usr/bin/html
RUN chmod -R 777 /var/www/html

RUN apachectl start

