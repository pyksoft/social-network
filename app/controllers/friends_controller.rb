class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends/new/1
  def friend_add
    # @friend = Friend.new(friend_params) 
    # puts @friend.account_id
    @friend_account_id = params[:friend_account_id]
    
    # # Get my profile
    # @my_profile = Profile.where("account_id = ?", current_account.id).first

    # Get my friend's profile
    @friend_profile = Profile.where("account_id = ?", @friend_account_id).first


    @friend = Friend.new
    # Link my friend's profile to my profile
    @friend.account = current_account

    # Manually link my friend's account to his account id
    @friend.friend_account_id = @friend_profile.account_id

    # Save to Follow Friend
    @friend.save

    # respond_to do |format|
    #   if @friend.save
    #     format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
    #     format.json { render :show, status: :created, location: @friend }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @friend.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # GET /friends
  # GET /friends.json
  def index
    # Get my profile
    # @my_profile = Profile.where("account_id = ?", current_account.id).first

    # Only get my Friends
    @friends = Friend.where("account_id = ?", current_account.id)
    # @friends = Friend.all

    @friends.each { |friend|
      profile = Profile.where("account_id = ?", friend.friend_account_id).first
      
      friend.first_name = profile.first_name
      friend.last_name = profile.last_name
      friend.photo = profile.photo
    }
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    profile = Profile.where("account_id = ?", @friend.friend_account_id).first
    
    @friend.first_name = profile.first_name
    @friend.last_name = profile.last_name
    @friend.photo = profile.photo
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)    

    @profiles = Profile.where("account_id = #{@friend.friend_account_id}")

    # puts "account_id = #{@friend.friend_account_id}"
    # print "Profile size: "
    # puts @profiles.size

  
    # Link friend to current account
    # @friend.account_id = current_account.id

    respond_to do |format|
      if @profiles.size > 0
        if @friend.save
          format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
          format.json { render :show, status: :created, location: @friend }
        else
          format.html { render :new }
          format.json { render json: @friend.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:friend_account_id)
    end
end
