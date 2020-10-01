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
        sample = json.sample

        case self.difficulty
        when "Easy"
            while sample.length > 5 do
                sample = json.sample
            end
    
        when "Hard"
            while sample.length < 9 do
                sample = json.sample
            end
            
        when "Medium" 
            until sample.length == (6..8)
                sample = json.sample
            end  
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
end




# binding.pry
