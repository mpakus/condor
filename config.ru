# frozen_string_literal: true

require 'bundler'
require_relative 'app/web'

Bundler.require(:default)
use Rack::Coffee, root: 'app/public', urls: '/javascripts'

run Web
