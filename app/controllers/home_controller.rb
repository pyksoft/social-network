class HomeController < ApplicationController

    def index
        # Get user profile
        @profiles = Profile.all

        # Since user can only have one profile at a time
        @profile = @profiles.detect { |p|
            p.account_id == current_account.id
        }

        puts "current_account: #{current_account.id}"

        # Get friends
        @friends = Friend.all
        @friends_count = @friends.count

        # Check if user's profile exists, if not create one
        if @profile.nil?
            redirect_to new_profile_path
        end

    end

end