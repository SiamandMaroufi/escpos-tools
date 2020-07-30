FROM php
RUN apt-get update
RUN apt-get install -y libmcrypt-dev git zip unzip libmagickwand-dev --no-install-recommends
RUN apt-get install -y apache2
RUN pecl install imagick \
RUN docker-php-ext-enable imagick

RUN rm -rf /var/www/html
RUN git clone https://github.com/SiamandMaroufi/escpos-tools.git /var/www/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo ':D' > '/var/www/html/index.html'

WORKDIR /var/www/html
RUN composer install

RUN echo 'echo $1 | base64 --decode > decoded.txt ; php /var/www/html/esc2text.php decoded.txt > /var/www/html/index.html' > /usr/bin/text
RUN echo 'echo $1 | base64 --decode > decoded.txt ; php /var/www/html/esc2html.php decoded.txt > /var/www/html/index.html' > /usr/bin/html

RUN chmod +x /usr/bin/text
RUN chmod +x /usr/bin/html

RUN apachectl start

