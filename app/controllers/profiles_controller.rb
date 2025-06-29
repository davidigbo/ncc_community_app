class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit update destroy vote]

  def show
    @profile = current_user.profile
    if @profile.nil?
      redirect_to new_profile_path, alert: 'Please create your profile first.'
    end
  end

  def edit
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def update
    if @profile.update(profile_params)
        redirect_to @profile, notice: 'Profile was successfully updated.'
    else
        render :edit
    end
  end

    def destroy
    @profile.destroy
    redirect_to profiles_url, notice: 'Profile was successfully destroyed.'
  end

  def vote
    @profile = Profile.find(params[:id])
    current_user.vote_for(@profile)
    redirect_to @profile, notice: 'Your vote has been recorded.'
  end

  private 
    def set_profile
      @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(:bio, :avatar)
    end

end
