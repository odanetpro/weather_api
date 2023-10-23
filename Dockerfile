FROM ruby:3.2.2-alpine

LABEL author=odanetpro

# Install packages
RUN apk add --update --no-cache \
    build-base \
    tzdata

# Install bundler
RUN gem install bundler

WORKDIR /app

# Copy application code
COPY . ./

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install
