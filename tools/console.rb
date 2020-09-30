require 'pry'
require "tty-prompt"
# require_relative '../app/models/user.rb'
# require_relative './app/models/game.rb'
# require_relative './app/models/user_game.rb'

prompt = TTY::Prompt.new
system('clear')

welcome = prompt.select("Main Menu") do |menu|
    menu.choice "Sign Up"
    menu.choice "Log In"
    menu.choice "Leader Board"
    menu.choice "Exit"

end

if welcome == "Log In"
    existing_usernames
    puts "Logs you in and youre ready to play!"
    # Perferibly we could have a method for the Log in menu
elsif welcome == "Sign Up"
    existing_usernames = prompt.collect do
        key(:username).ask("Whats youre username?")
        key(:password).mask("Create your new Password!")
    end
else welcome == "Leader Board"
     puts "A Leader Board"
end

puts existing_usernames
welcome

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