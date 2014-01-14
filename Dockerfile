# Rails Application

FROM yrpri/docker-base
MAINTAINER Robert Bjarnason <robert@citizens.is>

ENV DEBIAN_FRONTEND noninteractive

ENV APP_RUBY_VERSION 2.1.0
ENV RAILS_ENV production
ENV DB_USERNAME docker
ENV DB_PASSWORD docker

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install curl libpq-dev libxslt-dev libxml2-dev libmysqlclient-dev libmagickwand-dev 

RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN su root -c 'source /usr/local/rvm/scripts/rvm && rvm install $APP_RUBY_VERSION --default'

ADD start_passenger /opt/start_passenger
ADD supervisor.conf /etc/supervisor/conf.d/rails.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
