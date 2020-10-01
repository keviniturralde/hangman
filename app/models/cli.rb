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
            system('clear')
            welcome = TTY::Prompt.new.select("Main Menu") do |menu|
            menu.choice "Play a Game"
            menu.choice "Leader Board"
            menu.choice "Exit"
        end

        case welcome
        when "Play a Game"
            self.play_a_game
        when "Leader Board"
            puts "A Leader Board"
        when "Exit"
            system('clear')
            puts "Goodbye!" 
        end
    end
    
    def play_a_game
        system('clear')
        start_menu = TTY::Prompt.new.select("Sign up or Log in") do |menu|
            menu.choice "Sign Up"
            menu.choice "Log in"
            menu.choice "Back"
        end
        case start_menu
        when "Sign Up"
            self.sign_up
        when "Log in"
            self.log_in
        when "Back"
            self.welcome
        end
    end

    
    def sign_up
        system('clear')
        user = TTY::Prompt.new.collect do
            key(:username).ask("Please create a username.")
            key(:password).mask("Create your new Password!")
        end
        #check against usernames that exist so that the same username wont be used twice
        if User.all.map { |user| user.username }.include? (user[:username])
            puts "Sorry, that name has already been taken, please choose a new name."
            sleep(3)
            self.sign_up
        else
            User.create(user)
            self.difficulty_level
        end
    end
        
    def log_in
        system('clear')
        user = TTY::Prompt.new.collect do
            key(:username).ask("Please enter your username")
            key(:password).mask("Please enter your password")
        end
        if User.exists?(user)
            self.difficulty_level
        else 
            puts "Incorrect username or password"
            self.play_a_game  
        end
    end


    def difficulty_level
        difficulty = TTY::Prompt.new.select("Please choose difficulty level") do |menu|
            menu.choice "Easy"
            menu.choice "Medium"
            menu.choice "Hard"
        end 
        Game.create({difficulty: difficulty})
        self.set_game
    end

    def set_game
        current_game = Game.last
        current_game.random_word
        current_game.define
        current_game.save
    end

    def populate
        10.times do
            Game.create({difficulty: "Hard"})
            current_game = Game.last
            current_game.random_word
            current_game.define
            current_game.save
        end
    end
end

