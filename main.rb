require 'sinatra'
require 'open-uri'
require './fetch'

class Main < Sinatra::Application
  get '/' do
    fetch
  end
end
