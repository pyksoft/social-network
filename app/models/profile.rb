class Profile < ApplicationRecord
    belongs_to :account

    def self.search(search)
        # if search
        #     find(:all, :conditions => ['first_name LIKE ?', "%#{search}%"])
        # else
        #     find(:all)
        # end
    end
end
