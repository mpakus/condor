#!/usr/bin/env sh

gem install bundler --no-rdoc --no-ri
bundle install
bundle exec rackup -p 3000

