FROM php:7.1.3-fpm
​
RUN apt-get update && apt-get install -y libmcrypt-dev \
    git zip unzip \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
&& docker-php-ext-install mcrypt pdo_mysql
​
RUN rm -rf /var/www/html
RUN git clone https://github.com/SiamandMaroufi/escpos-tools.git /var/www/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
​
WORKDIR /var/www/html
RUN composer install
​
RUN echo 'echo $1 | base64 --decode > decoded.txt ; php /var/www/html/esc2text.php decoded.txt' > /usr/bin/text
RUN echo 'echo $1 | base64 --decode > decoded.txt ; php /var/www/html/esc2html.php decoded.txt' > /usr/bin/html
​
RUN chmod +x /usr/bin/text
RUN chmod +x /usr/bin/html
