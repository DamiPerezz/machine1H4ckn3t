FROM ubuntu:20.04

ENV TZ="Europe/Madrid"

RUN apt update

RUN apt-get install -yq tzdata && \
ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata

RUN apt install -y apache2 

RUN apt install apache2-utils -y 

RUN a2enmod request \
    && a2enmod auth_form \
    && a2enmod session \
    && a2enmod session_cookie \
    && a2enmod session_crypto \
    && a2enmod rewrite

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

COPY html/ /var/www/html/

RUN htpasswd -bc /etc/apache2/.htpasswd admin 1234567890 \
    && chmod 640 /etc/apache2/.htpasswd \
    && chown www-data:www-data /etc/apache2/.htpasswd
    
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]