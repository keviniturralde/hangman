require 'httparty'
require 'json'
require 'pry'
require 'dotenv'
require 'tty-prompt'
require 'active_record'
require 'colorize'
Dotenv.load('./.env')



class Game < ActiveRecord::Base
    has_many :user_games
    has_many :users, through: :user_games    

    def random_word
        response = HTTParty.get("https://raw.githubusercontent.com/RazorSh4rk/random-word-api/master/words.json")
        json = JSON.parse(response.body)
        json = json.select { |word| word.length > 3 && word.length < 14 }
        easy = json.select { |word| word.length < 6}
        medium = json.select { |word| word.length > 5 && word.length < 10 }
        hard = json.select { |word| word.length > 9 }
        
        case self.difficulty
        when "Easy"
            sample = easy.sample
        when "Hard"
            sample = hard.sample  
        when "Medium" 
            sample = medium.sample
        end
        self.word = sample
    end
    

    def define
        response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{self.word}?key=#{ENV['WEBSTER_KEY']}")
        json = JSON.parse(response.body)
        if json[0].is_a?(String)
            response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{json[0]}?key=#{ENV['WEBSTER_KEY']}")
            json = JSON.parse(response.body)
            definition = json[0].dig("def")
            entry = definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
            self.hint = entry.gsub("{bc}", "").gsub("{sx|", "").gsub("{a_link|", "").gsub("{d_link|", "").gsub("||", "").gsub("}", "").gsub("{", "").gsub(":1", "").gsub(":2", "").gsub("dxsee dxt|", "").gsub("/dx", "")
        else
            definition = json[0].dig("def")
            entry = definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
            self.hint = entry.gsub("{bc}", "").gsub("{sx|", "").gsub("{a_link|", "").gsub("{d_link|", "").gsub("||", "").gsub("}", "").gsub("{", "").gsub(":1", "").gsub(":2", "").gsub("dxsee dxt|", "").gsub("/dx", "")
        end
    end

    def start
        system('clear')
        prompt = TTY::Prompt.new
        prompt.keypress("Your word is #{self.word.length} letters long! Press space or enter to continue", keys: [:space, :return])
        prompt.keypress("Your hint is: #{self.hint}", keys: [:space, :return])
        prompt.keypress("Make #{self.available_guesses} incorrect guesses, and you lose!", keys: [:space, :return])
        self.word_teaser
        
    end

    def word_teaser
        @teaser = []
        @wrong_guess = []
        self.word.length.times do
            @teaser << "_ "
        end
        puts @teaser.join("")
        self.make_a_guess
    end

    def make_a_guess
        if self.available_guesses > 0
            if @teaser.join("") == self.word
                self.win
            else
                puts "Guess a letter!"
                puts "Wrong Guesses: #{@wrong_guess.join(",")}".red
                puts "You have #{self.available_guesses} guesses remaining!"
                puts "Your hint is: #{self.hint}"
                word_array = self.word.split("")
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
                    self.available_guesses -= 1
                    @wrong_guess << guess
                    puts "Sorry, your guess was incorrect. You have #{self.available_guesses} guesses remaining!"
                    puts @teaser.join("") 
                    self.make_a_guess
                end
            end
        else
            system('clear')
            puts "You Lose!"
            puts "The correct word was #{self.word}!"
        end
    end

    def win
        current_user_game = UserGame.last
        current_user_game.won_game = true
        current_user_game.save
        current_user_game.user.score += 1
        current_user_game.user.save
        system("clear")
        puts "#{self.word.green} : #{self.hint}"
        puts "You WIN!"
    end
end




# binding.pry
