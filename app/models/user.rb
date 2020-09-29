require 'active_record'

class User < ActiveRecord::Base
    has_many :userGames
    has_many :games, through: :userGames
end

def existing_user?
    self.find_or_create_by(username: self)
end 