require 'active_record'

class User < ActiveRecord::Base
    has_many :userGames
    has_many :games, through: :userGames
end



# def score 
#     @score = self.userGames.map {|ug|ug.won_game == true}.count
# end 

