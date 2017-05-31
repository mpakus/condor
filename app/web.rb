# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sass'
require 'slim'

# Web Backend
class Web < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set(:public_folder, proc { File.join(root, 'public') })
    set(:views, proc { File.join(root, 'views') })
    Slim::Engine.set_options pretty: true
  end

  get '/' do
    slim :index
  end

  get '/airlines' do
  end

  get '/airports' do
  end

  post '/search' do
  end

  post 'flight_search/:airline_code' do
  end
end
