# require_relative 'game.rb'
require_relative 'user.rb'
require 'pry'


def run
    puts "Welcome, would you like to play a game or check the Leaderboard?"
    choice = gets.chomp
    if choice == "Play a game"
    puts "What is your username?"
    username = gets.chomp
    else choice == "Check the Leaderboard"
    end 
end 


# binding.pry 