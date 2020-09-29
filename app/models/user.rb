class User < ActiveRecord::Base
    has_many :userGames
    has_many :games, through: :userGames
end