FROM ubuntu:20.04
RUN apt-get update -y && apt-get install -y software-properties-common language-pack-en-base

RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  add-apt-repository -y ppa:opencpu/opencpu-2.2 && \
  apt-get update && \
  apt-get install -y wget make devscripts apache2-dev apache2 libapreq2-dev r-base r-base-dev libapparmor-dev libcurl4-openssl-dev libprotobuf-dev protobuf-compiler libcairo2-dev xvfb xauth xfonts-base curl libssl-dev libxml2-dev libicu-dev pkg-config libssh2-1-dev locales apt-utils cron
  

RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get -y update && apt-get install -y \
    php7.0 \
    php7.0-pgsql \
    php-mcrypt \
    php7.0-cli \
    php7.0-xml \
    php7.0-mbstring \
    php7.0-gd
	
RUN cp /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo "Asia/Kolkata" >  /etc/timezone

RUN a2enmod rewrite
#RUN service apache2 restart
	
#RUN service apache2 restart

COPY apache2.conf /etc/apache2/
#ADD central.tar.gz /var/www/html/
#RUN chmod -R 777 /var/www/html/central

COPY ixed.7.0.lin /usr/lib/php/20151012/
COPY php.ini /etc/php/7.0/apache2/
COPY root /var/spool/cron/crontabs/
#COPY .htaccess /var/www/html/central/
#COPY web/.htaccess /var/www/html/central/web/


RUN update-alternatives --set php /usr/bin/php7.0
WORKDIR /var/www/html/

# Apache ports
EXPOSE 80
EXPOSE 443


# Start non-daemonized webserver
CMD  apachectl -DFOREGROUND

