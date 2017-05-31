require 'bundler'
require 'sass/plugin/rack'
require_relative 'app/web'

Bundler.require(:default)
Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack
use Rack::Coffee, root: 'public', urls: '/javascripts'

run Web

