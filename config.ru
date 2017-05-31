require 'bundler'
Bundler.require(:default)

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack
use Rack::Coffee, root: 'public', urls: '/javascripts'

require_relative 'app/web'

run Web

