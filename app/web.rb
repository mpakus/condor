require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sass'
require 'slim'

class Web < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set :public_folder, Proc.new { File.join(root, 'public') }
    set :views, Proc.new { File.join(root, 'views') }
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