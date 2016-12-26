FROM phusion/passenger-full
# we want to test several rubies
# prefer baseimage over ubuntu/debian and alpine

MAINTAINER Pawel Przylucki <roxermc@gmail.com> (@roxer)

RUN apt-get update && \
    apt-get install -y --force-yes \
      build-essential \
      zlib1g-dev \
      libpq-dev \
      git-core \
      curl \
      libssl-dev \
      libreadline-dev \
      libyaml-dev \
      libsqlite3-dev \
      sqlite3 \
      libxml2-dev \
      libxslt1-dev \
      libcurl4-openssl-dev \
      python-software-properties \
      libffi-dev \
      nodejs \
    \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV     CONFIGURE_OPTS --disable-install-doc

WORKDIR /app
COPY    Gemfile      /app/Gemfile
COPY    Gemfile.lock /app/Gemfile.lock
RUN     gem install bundler
RUN     bundle install  --binstubs --jobs 20 --retry 5

COPY    . /app

# TODO: create user for app (other than root)

# RUN bundle exec rake assets:precompile RAILS_ENV=development

# EXPOSE 3000
# EXPOSE 28080

# CMD ["bundle", "exec", "puma", "-p 28080", "cable/config.ru"]
# CMD ["bundle", "exec", "rails", "server"]
