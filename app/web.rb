require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'

class Web < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
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