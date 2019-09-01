# Referenced from: https://github.com/gad0lin/docker-ruby-2.2.1
# Base image
FROM ubuntu:16.04

LABEL maintain="taher435@gmail.com"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN \
  apt-get update && \
  apt-get install -y ruby ruby-dev ruby-bundler git nodejs software-properties-common \
  autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libpq-dev wget tzdata

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  exec $SHELL && \
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

RUN /root/.rbenv/bin/rbenv install 2.2.1
RUN /root/.rbenv/bin/rbenv global 2.2.1
