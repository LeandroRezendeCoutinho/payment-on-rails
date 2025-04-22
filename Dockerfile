FROM ruby:3.4-slim

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app/
