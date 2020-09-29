class Game < ActiveRecord::Base
    has_many :userGames
    has_many :users, through: :userGames
end 