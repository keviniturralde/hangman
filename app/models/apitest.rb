require 'httparty'
require 'json'
require 'pry'
require 'dotenv'
Dotenv.load('./.env')


class ApiTest
    attr_accessor :word
    
    
    def random_word(level)
        response = HTTParty.get("https://raw.githubusercontent.com/RazorSh4rk/random-word-api/master/words.json")
        json = JSON.parse(response.body)
        @word = json.sample

        case level
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
end

# game = ApiTest.new
# word = game.random_word
# binding.pry
