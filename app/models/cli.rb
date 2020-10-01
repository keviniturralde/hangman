require_relative 'game.rb'
require_relative 'user.rb'
require_relative 'userGame.rb'

require 'pry'
require 'artii'
require 'colorize'
require 'active_record'
require 'tty-prompt'
require 'terminal-table'
require 'httparty'
require 'json'
require 'dotenv'
Dotenv.load('./.env')




class Cli

    def title_screen
        a = Artii::Base.new :font => 'alligator'
        3.times do 
        system("clear")
        puts a.asciify('_______').light_green
        sleep(0.3)
        system("clear")
        puts a.asciify('H______').light_green
        sleep(0.3)
        system("clear")
        puts a.asciify('H__G___').light_green
        sleep(0.3)
        system("clear")
        puts a.asciify('H__GM__').light_green
        sleep(0.3)
        system("clear")
        puts a.asciify('H_NGM_N').light_green
        sleep(0.3)
        system("clear")
        puts a.asciify('HANGMAN').light_green
        sleep(1)
        system("clear")
        end
        self.welcome
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
            self.leaderboard
        when "Exit"
            system('clear')
            a = Artii::Base.new :font => 'alligator' 
            puts a.asciify('Goodbye!').red
            sleep(3)
        end
    end

    def leaderboard
        top_users = User.order('score DESC limit 3')
        rows = []
        rows << [top_users[0].username, top_users[0].score]
        rows << [top_users[1].username, top_users[1].score]
        rows << [top_users[2].username, top_users[2].score]
        table = Terminal::Table.new :title => "Leaderboard", :headings => ['Username', 'Games Won'], :rows => rows 
        system('clear')
        puts table
        TTY::Prompt.new.keypress("Press any key to return to the main menu")
        self.welcome
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
            key(:username).ask("Please enter your Username")
            key(:password).mask("Create your new Password")
        end
        #check against usernames that exist so that the same username wont be used twice
        if User.all.map { |user| user.username }.include? (user[:username])
            puts "Sorry, that name has already been taken"
            sleep(2)
            attempt = TTY::Prompt.new.select("Sign up or Log in") do |menu|
                menu.choice "Try Again"
                menu.choice "Back"
            end
            case attempt
            when "Try Again"
                self.sign_up
            when "Back"
                self.play_a_game
            end

        else
            @current_user = User.create(user)
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
            @current_user = User.find_by_username(user[:username])
            self.difficulty_level
        else 
            puts "Incorrect username or password"
            sleep(2)
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
        @current_game = Game.last
        self.random_word
        self.define
        @current_game.save
        @current_user_game = UserGame.create({user_id: @current_user.id, game_id: @current_game.id})
        self.start
    end

    def random_word
        response = HTTParty.get("https://raw.githubusercontent.com/RazorSh4rk/random-word-api/master/words.json")
        json = JSON.parse(response.body)
        json = json.select { |word| word.length > 3 && word.length < 14 }
        easy = json.select { |word| word.length < 6}
        medium = json.select { |word| word.length > 5 && word.length < 10 }
        hard = json.select { |word| word.length > 9 }
        
        case @current_game.difficulty
        when "Easy"
            sample = easy.sample
        when "Hard"
            sample = hard.sample  
        when "Medium" 
            sample = medium.sample
        end
        @current_game.word = sample
    end

    def define
        response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{@current_game.word}?key=#{ENV['WEBSTER_KEY']}")
        json = JSON.parse(response.body)
        if json[0].is_a?(String)
            response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{json[0]}?key=#{ENV['WEBSTER_KEY']}")
            json = JSON.parse(response.body)
            definition = json[0].dig("def")
            entry = definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
            @current_game.hint = entry.gsub("{bc}", "").gsub("{sx|", "").gsub("{a_link|", "").gsub("{d_link|", "").gsub("||", "").gsub("}", "").gsub("{", "").gsub(":1", "").gsub(":2", "").gsub("dxsee dxt|", "").gsub("/dx", "")
        else
            definition = json[0].dig("def")
            entry = definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
            @current_game.hint = entry.gsub("{bc}", "").gsub("{sx|", "").gsub("{a_link|", "").gsub("{d_link|", "").gsub("||", "").gsub("}", "").gsub("{", "").gsub(":1", "").gsub(":2", "").gsub("dxsee dxt|", "").gsub("/dx", "")
        end
    end

    def start
        system('clear')
        prompt = TTY::Prompt.new
        prompt.keypress("Your word is #{@current_game.word.length} letters long! Press space or enter to continue", keys: [:space, :return])
        prompt.keypress("Your hint is: #{@current_game.hint}", keys: [:space, :return])
        prompt.keypress("Make #{@current_game.available_guesses} incorrect guesses, and you lose!", keys: [:space, :return])
        self.word_teaser
    end

    def word_teaser
        @teaser = []
        @wrong_guess = []
        @current_game.word.length.times do
            @teaser << "_ "
        end
        puts @teaser.join("")
        self.make_a_guess
    end

    def make_a_guess
        if @current_game.available_guesses > 0
            if @teaser.join("") == @current_game.word
                self.win
            else
                puts "Guess a letter!"
                puts "Wrong Guesses: #{@wrong_guess.join(",")}".red
                puts "You have #{@current_game.available_guesses} guesses remaining!"
                puts "Your hint is: #{@current_game.hint}"
                word_array = @current_game.word.split("")
                guess = gets.chomp
                
                if word_array.include?(guess)
                    system('clear')
                    @teaser.each_with_index do |char, i| 
                        if word_array[i] == guess
                            @teaser[i] = guess
                        end
                    end
                    puts "Nice!"
                    puts @teaser.join("") 
                    self.make_a_guess
                else
                    system('clear')
                    @current_game.available_guesses -= 1
                    @wrong_guess << guess
                    puts "Sorry, your guess was incorrect. You have #{@current_game.available_guesses} guesses remaining!"
                    puts @teaser.join("") 
                    self.make_a_guess
                end
            end
        else
            system('clear')
            puts "You Lose!"
            puts "The correct word was #{@current_game.word}!"
            sleep(2)
            again = TTY::Prompt.new.select("Would you like to play again?") do |menu|
                menu.choice "Yes"
                menu.choice "No"
                menu.choice "Exit"
            end 
            case again
            when "Yes"
                self.difficulty_level
            when "No"
                self.welcome
            when "Exit"
                puts "Thanks for playing!"
                sleep(2)
            end
        end
    end

    def win
        @current_user_game.won_game = true
        @current_user_game.save
        @current_user.score += 1
        @current_user.save
        system("clear")
        puts "#{@current_game.word.green} : #{@current_game.hint}"
        puts "You WIN!"
        sleep(2)
        again = TTY::Prompt.new.select("Would you like to play again?") do |menu|
            menu.choice "Yes"
            menu.choice "No"
            menu.choice "Exit"
        end 
        case again
        when "Yes"
            self.difficulty_level
        when "No"
            self.welcome
        when "Exit"
            puts "Thanks for playing!"
            sleep(2)
        end
    end
end




