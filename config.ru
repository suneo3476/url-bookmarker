require 'rubygems'
require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'
require 'sqlite3'
require 'sanitize'

require './server.rb'

run Sinatra::Application