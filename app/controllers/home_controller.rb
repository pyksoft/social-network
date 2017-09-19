class HomeController < ApplicationController

    def index
        # Get user profile
        @profiles = Profile.all

        # Since user can only have one profile at a time
        @profile = @profiles.detect { |p|
            p.account_id == current_account.id
        }

        puts "current account id: #{current_account.id}"
        # puts "current profile id: #{@profile.id}"

        # Get friends of current user
        @friends = Friend.where("account_id = ?", current_account.id)
        @friends_count = @friends.count

        # Check if user's profile exists, if not create one
        if @profile.nil?
            redirect_to new_profile_path
        end

        # You will only be able to see your posts and your friends' posts
        news_profile_ids = []
        news_profile_ids << current_account.profile.id
        @friends.each { |friend|
            news_profile_ids <<  friend.friend_account_id
        }
        @news = News.where("profile_id IN (?)", news_profile_ids)
    end

end