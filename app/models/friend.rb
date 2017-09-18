class Friend < ApplicationRecord
    attr_accessor :first_name, :last_name, :photo
    belongs_to :account
end
