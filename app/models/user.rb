require 'active_record'

class User < ActiveRecord::Base
    has_many :user_games
    has_many :games, through: :user_games
end



# def score 
#     @score = self.userGames.map {|ug|ug.won_game == true}.count
# end 

