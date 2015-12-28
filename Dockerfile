FROM debian:jessie
# prefer debian over ubuntu

MAINTAINER Pawel Przylucki <roxermc@gmail.com> (@roxer)

WORKDIR /app

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
    && apt-get clean \
    && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
    && /root/.rbenv/plugins/ruby-build/install.sh

# ruby2.2 \
# ruby=1:2.1.5 \
# nodejs=0.10.29~dfsg-2 && \

ENV echo 'eval "$(rbenv init -)"' >> /etc/profile
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
ENV CONFIGURE_OPTS --disable-install-doc

# Install ruby 2.2.3
RUN rbenv install 2.2.3 \
    && rbenv rehash \
    && echo 'gem: --no-rdoc --no-ri' >> /.gemrc \
    && rbenv global 2.2.3 \
    && gem install bundler

ADD Gemfile      /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4

ADD . /app

# TODO: create user for app (other than root)

# RUN bundle exec rake assets:precompile RAILS_ENV=development

# EXPOSE 3000
# EXPOSE 28080

# CMD ["bundle", "exec", "puma", "-p 28080", "cable/config.ru"]
# CMD ["bundle", "exec", "rails", "server"]
