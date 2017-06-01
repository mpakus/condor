# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'slim'
require_relative 'services/flight/airlines'
require_relative 'services/flight/airports'
require_relative 'services/flight/search'

# Web Backend
class Web < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set(:public_folder, proc { File.join(root, 'public') })
    set(:views, proc { File.join(root, 'views') })
    set(:dump_errors, false)
    set(:raise_errors, true)
    set(:show_exceptions, :after_handler)
    Slim::Engine.set_options pretty: true
  end

  error StandardError do |err|
    json status: :error, message: err
  end

  get '/' do
    slim :index
  end

  get '/airlines' do
    json status: :ok, data: Flight::Airlines.new.perform
  end

  get '/airports' do
    json status: :ok, data: Flight::Airports.new(params[:q]).perform
  end

  get '/search' do
    results = Flight::Search.new(params[:departure], params[:destination], params[:date]).perform!
    json status: :ok, data: results
  end
end
