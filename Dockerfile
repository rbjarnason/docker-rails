# Rails Application V2

FROM yrpri/base
MAINTAINER Robert Bjarnason <robert@citizens.is>

ENV DEBIAN_FRONTEND noninteractive

ENV APP_RUBY_VERSION 2.0.0
ENV RAILS_ENV development
ENV DB_USERNAME docker
ENV DB_PASSWORD docker

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install curl git libpq-dev libxslt-dev libxml2-dev libmysqlclient-dev libmagickwand-dev imagemagick

RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN su root -c 'source /usr/local/rvm/scripts/rvm && rvm install $APP_RUBY_VERSION --default'

ADD start_passenger /opt/start_passenger
ADD supervisor.conf /etc/supervisor/conf.d/rails.conf

EXPOSE 3000

CMD ["/usr/bin/supervisord"]
