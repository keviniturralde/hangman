require 'pry'
require "tty-prompt"
require "tty-screen"
require 'tty-cursor'
require 'active_record'
require_relative '../config/environment.rb'

system('clear')
game = Cli.new
# game.title_screen
game.welcome

# def move_cursor_to_required_coordinates(text)
#     x = (@width - text.length) / 2
#     y = (@height) / 2
#     print @cursor.move_to(x, y)
#   end
  
#   def centered_text(text)
#     move_cursor_to_required_coordinates(text)
#     puts text
#   end

# centered_text(welcome)

# puts existing_usernames






