class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profiele, only: %i[show edit update destroy vote]

  def show
  end

  def edit
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
    def set_profiele
      @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(:bio, :avatar, :tag_list)
    end

end
