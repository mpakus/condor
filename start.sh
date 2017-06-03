#!/usr/bin/env sh

gem install bundler --no-rdoc --no-ri
bundle install
rackup -p 3000

