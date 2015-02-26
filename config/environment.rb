require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sequel'
require 'pry'
require 'logger'
require 'json'
require 'fog'
require 'securerandom'
require 'sinatra/base'

require './app/coordinator'
Coordinator.config(ENV)

require './config/memory_db'
require './app/models/worker'
require './app/models/test'
require './app/controllers/work'
