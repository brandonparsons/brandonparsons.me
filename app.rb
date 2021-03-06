require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'

class SinatraApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    slim :index
  end

  not_found do
    status 404
    slim :not_found
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
