require 'active_record'

class User < ActiveRecord::Base
    has_many :user_games
    has_many :games, through: :user_games
end


# user.score += 1 if user.user_game.won_game == true

# def self.calculate_score 
#     self.all.map { |user| user.score = }
#            @score = UserGame.won_game.count
#         end 
#     end 
# end 

