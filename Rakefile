require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'pry'


desc "Start our app console"
  task :console do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    Pry.start
  end
require_all 'app/models'