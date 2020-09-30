require 'pry'
require "tty-prompt"
require "tty-screen"
require 'tty-cursor'
# require_relative '../app/models/user.rb'
# require_relative './app/models/game.rb'
# require_relative './app/models/user_game.rb'

prompt = TTY::Prompt.new
@cursor = TTY::Cursor
@size = TTY::Screen.size
@height = @size[0]
@width = @size[0]


system('clear')

welcome = prompt.select("Main Menu") do |menu|
    menu.choice "Sign Up"
    menu.choice "Log In"
    menu.choice "Leader Board"
    menu.choice "Exit"
end

def move_cursor_to_required_coordinates(text)
    x = (@width - text.length) / 2
    y = (@height) / 2
    print @cursor.move_to(x, y)
  end
  
  def centered_text(text)
    move_cursor_to_required_coordinates(text)
    puts text
  end

centered_text(welcome)

if welcome == "Log In"
    puts "Logs you in and youre ready to play!"
    # Perferibly we could have a method for the Log in menu
elsif welcome == "Sign Up"
    existing_usernames = prompt.collect do
        puts key(:username).ask("Whats youre username?")
        key(:password).mask("Create your new Password!")
    end
else welcome == "Leader Board"
     puts "A Leader Board"
end

puts existing_usernames













# def main_menu
# prompt.select("Main Menu", %w(Create_new_user Sign_in Leader_board))
# if main_menu == Create_new_user
#     user = User.new
# elseif main_menu == Sign_in
#     user.exist(:name => self.name)
# else Leader_board
#     puts "the Leader Board"
# end
# main_menu
# end

# def Create_new_user?
#     @user = User.new
#     puts main_menu
# end

# prompt.ask("What is your name?", default: ENV["USER"])