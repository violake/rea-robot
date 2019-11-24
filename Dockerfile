FROM ruby:2.5.0

ENV BUNDLER_VERSION='2.0.2'

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app
ADD Gemfile.lock /app

RUN gem install bundler && bundle install

ADD . /app/

ENTRYPOINT ["/bin/bash"]