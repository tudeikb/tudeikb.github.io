FROM ruby:3.1

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock just-the-docs.gemspec ./ package*.json ./

RUN gem install bundler && bundle install && \
  apt-get update && apt-get install -y \
  nodejs npm && \
  rm -rf /var/lib/apt/lists/* && \
  npm install 

EXPOSE 4000
