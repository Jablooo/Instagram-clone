class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
   # Make user set up their profile page if they haven’t yet by sending them to edit profile
   # @profile hasnt been set yet either so line two send tehm there with before action.
   redirect_to edit_profile_url if @profile.nil?
  end

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find_or_initialize_by(user: current_user)
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        # instead of @profile ^ could use profile_path
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if performing_follow?
        @profile.user.toggle_followed_by(current_user)
        format.html { redirect_to @profile.user }
        format.json { render :show, status: :ok, location: @profile }
      elsif @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   # can't be accessed from the views but can be accessed within these methods
  def set_profile
    if params[:id]
       # A particular person’s profile page
       # e.g. /users/5
      @profile = Profile.find_by!(user_id: params[:id])
    else
       # The signed in user’s profile page
       # /profile
      @profile = Profile.find_by(user: current_user)
    end
  end

   # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:username, :name, :bio) #they come from the form on websites so if you wanted to add something like avatar data you'd have to specify here too
  end

  def performing_follow?
    params.require(:user)[:toggle_follow].present?
  end

end
