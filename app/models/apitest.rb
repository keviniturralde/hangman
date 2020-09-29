require 'httparty'
require 'json'
require 'pry'


class ApiTest
    attr_accessor :word
    
    
    def random_word
        response = HTTParty.get("https://raw.githubusercontent.com/RazorSh4rk/random-word-api/master/words.json")
        json = JSON.parse(response.body)
        @word = json.sample
    end
    
    def define
        
        response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{@word}?key=#{$key}")
        json = JSON.parse(response.body)
        if json[0].is_a?(String)
            response = HTTParty.get("https://dictionaryapi.com/api/v3/references/collegiate/json/#{json[0]}?key=#{$key}")
            json = JSON.parse(response.body)
            definition = json[0].dig("def")
            definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
        else
            definition = json[0].dig("def")
            definition[0].dig("sseq").flatten[1].dig("dt").flatten[1]
        end
    end
end

game = ApiTest.new
# word = game.random_word
binding.pry