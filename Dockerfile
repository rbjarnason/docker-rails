# Rails Application

FROM zumbrunnen/base
MAINTAINER David Zumbrunnen <zumbrunnen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install curl libapache2-mod-passenger libpq-dev

RUN echo "ServerName \$HOSTNAME.localdomain" > /etc/apache2/conf.d/fqdn

RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.0.0
RUN source /usr/local/rvm/scripts/rvm && rvm install 1.9.3 && rvm use 2.0.0 --default

ADD setup /opt/setup
ADD start_apache /opt/start_apache
ADD supervisor.conf /etc/supervisor/conf.d/rails.conf

VOLUME ["/var/www/app"]
EXPOSE 80

CMD ["/usr/bin/supervisord"]
