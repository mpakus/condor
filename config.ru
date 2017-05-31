# frozen_string_literal: true

require 'bundler'
require 'sass/plugin/rack'
require_relative 'app/web'

Bundler.require(:default)
Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack
use Rack::Coffee, root: 'app/public', urls: '/javascripts'

run Web
