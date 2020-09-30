require_relative 'game.rb'
require_relative 'user.rb'
require_relative 'userGame.rb'

require 'pry'
require 'artii'
require 'colorize'
require 'active_record'
require 'tty-prompt'



class Cli


    def title_screen
        a = Artii::Base.new :font => 'isometric2'
        3.times do 
        system("clear")
        puts a.asciify('_______').light_green
        sleep(0.5)
        system("clear")
        puts a.asciify('H______').light_green
        sleep(0.5)
        system("clear")
        puts a.asciify('H__G___').light_green
        sleep(0.5)
        system("clear")
        puts a.asciify('H__GM__').light_green
        sleep(0.5)
        system("clear")
        puts a.asciify('H_NGM_N').light_green
        sleep(0.5)
        system("clear")
        puts a.asciify('HANGMAN').light_green
        sleep(2)
        system("clear")
        end
    end

    # def intro2
#     a = Artii::Base.new :font => 'alligator'
#     puts a.asciify('H').light_green
#     sleep(0.5)
#     system("clear")
#     puts a.asciify('HA').light_green
#     sleep(0.5)
#     system("clear")
#     puts a.asciify('HAN').light_green
#     sleep(0.5)
#     system("clear")
#     puts a.asciify('HANG').light_green
#     sleep(0.5)
#     system("clear")
#     puts a.asciify('HANGM').light_green
#     sleep(0.5)
#     system("clear")
#     puts a.asciify('HANGMA').light_green
#     sleep(0.5)
#     system("clear")
#     puts a.asciify('HANGMAN').light_green
#     sleep(3)
#     puts "|/|".center(40)
#     sleep(0.3)
#     puts "|/|".center(40)
#     sleep(0.3)
#     puts "|/|".center(40)
#     sleep(0.3)
#     puts "|/|".center(40)
#     sleep(0.3)
#     puts "|/|".center(40)
#     sleep(0.3)
#     puts "|/|".center(40)
#     sleep(0.3)
#     puts "|/| /¯)".center(40)
#     sleep(0.3)
#     puts "|/|/ /".center(40)
#     sleep(0.3)
#     puts "|/| /".center(40)
#     sleep(0.3)
#     puts "(¯¯¯)".center(40)
#     sleep(0.3)
#     puts "(¯¯¯)".center(40)
#     sleep(0.3)
#     puts "(¯¯¯)".center(40)
#     sleep(0.3)
#     puts "(¯¯¯)".center(40)
#     sleep(0.3)
#     puts "(¯¯¯)".center(40)
#     sleep(0.3)
#     puts "/¯¯/ ".center(40)
#     sleep(0.3)
#     puts "/ ,^./ ".center(40)
#     sleep(0.3)
#     puts "/ /    / ".center(40)
#     sleep(0.3)
#     puts "/ /      / ".center(40)
#     sleep(0.3)
#     puts "( (       )/)".center(40)
#     sleep(0.3)
#     puts "| |       |/|".center(40)
#     sleep(0.3)
#     puts "| |       |/|".center(40)
#     sleep(0.3)
#     puts "| |       |/|".center(40)
#     sleep(0.3)
#     puts "( (       )/)".center(40)
#     sleep(0.3)
#     puts "        / /".center(40)
#     sleep(0.3)
#     puts "  `---' /".center(40)
#     sleep(0.3)
#     puts "`-----'".center(40)
# end

    def welcome
        welcome = TTY::Prompt.new.select("Main Menu") do |menu|
            menu.choice "Sign Up"
            menu.choice "Log In"
            menu.choice "Leader Board"
            menu.choice "Exit"
        end

        case welcome
        when "Sign Up"
            user = TTY::Prompt.new.collect do
                key(:username).ask("Whats youre username?")
                key(:password).mask("Create your new Password!")
            end
            User.create({username: user[:username], password: user[:password]})
            
        when "Log In"
            puts "Logs you in and youre ready to play!"
            # Perferibly we could have a method for the Log in menu
        when "Leader Board"
            puts "A Leader Board"
        when "Exit"
            system('clear')
            puts "Goodbye!"
            
        end
    end
end

