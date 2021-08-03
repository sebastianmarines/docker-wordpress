FROM nginx:1.20.1

RUN mkdir /var/run/php

RUN apt update -y && apt upgrade -y
RUN apt install -y php php-fpm php-mysql
RUN apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

COPY wordpress /var/www/wordpress
COPY wp.conf /etc/nginx/conf.d/default.conf
COPY wp-config.php /var/www/wordpress/wp-config.php

RUN ln -s /usr/sbin/php-fpm7.3 /usr/sbin/php-fpm
RUN php-fpm &
RUN touch /var/run/php/php7.3-fpm.sock
RUN chmod 777 /var/run/php/php7.3-fpm.sock

EXPOSE 80
