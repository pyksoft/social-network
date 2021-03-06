class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    
    # Search Profile Functionality
    if params[:search]
      @profiles = Profile.where('(first_name LIKE ? OR last_name LIKE ? OR first_name||" "||last_name LIKE ?) AND account_id <> ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", current_account.id)
    else
      @profiles = Profile.where('account_id <> ?', current_account.id)
    end

    # Detect if profile is already a friend of the current account
    # Friend.where('account_id = ? AND friend_account_id = ?', "#{current_account.id}", @profiles.)

    # Get my friends
    @friends = Friend.where('account_id = ?', current_account.id)

    # Check profile if you follow them
    @profiles.each { |profile|
      
      friend = @friends.detect { |friend|
        friend.account_id == current_account.id && profile.account_id == friend.friend_account_id
      }
      
      if friend.nil?
        profile.is_followed = false
      else
        profile.is_followed = true
        profile.friend_id = friend.id
      end
    }
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    # You cannot edit other people's profile
    if @profile != current_account.profile
      redirect_to root_path
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    # Link the account to the profile
    @profile.account = current_account

    respond_to do |format|
      if @profile.save
        format.html { redirect_to root_path, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    # You cannot delete other people's profile
    if @profile != current_account.profile
      redirect_to root_path
    end

    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :photo)
    end
end
