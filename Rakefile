require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'pry'
require "tty-prompt"
# require 'dotenv'
# Dotenv.load

desc "Start our app console"

  task :console do
    Pry.start
  end


  
require_all 'app/models'