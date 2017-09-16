class HomeController < ApplicationController

    def index
        # Get user profile
        @profiles = Profile.all
        
        # Since user can only have one profile at a time
        @profile = @profiles.first

        # Check if user's profile exists, if not create one
        if @profiles.size == 0
            redirect_to new_profile_path
        end
    end

end