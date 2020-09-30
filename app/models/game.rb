require 'httparty'
require 'json'
require 'pry'
require 'dotenv'
require 'active_record'
Dotenv.load('./.env')



class Game < ActiveRecord::Base
    has_many :userGames
    has_many :users, through: :userGames    

    def random_word
        response = HTTParty.get("https://raw.githubusercontent.com/RazorSh4rk/random-word-api/master/words.json")
        json = JSON.parse(response.body)
        @word = json.sample

        case difficulty
        when "easy"
            while @word.length > 5 do
                @word = json.sample
            end
        when "hard"
            while @word.length < 9 do
                @word = json.sample
            end
        else
            until @word.length == (6..8)
                @word = json.sample
            end
        end
        @word
    end
    
# binding.pry


    def define
        
        response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{@word}?key=#{ENV['WEBSTER_KEY']}")
        json = JSON.parse(response.body)
        if json[0].is_a?(String)
            response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{json[0]}?key=#{ENV['WEBSTER_KEY']}")
            json = JSON.parse(response.body)
            definition = json[0].dig("def")
            @hint = definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
        else
            definition = json[0].dig("def")
            @hint = definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
        end
    end



    # def guesses 
    #     gets.chomp 
    # end 
    
end
