class Profile < ApplicationRecord
    attr_accessor :is_followed, :friend_id
    
    belongs_to :account
end
