class Admin::BusinessProfilesController < ApplicationController
  before_action :set_business_profile, only: %i[show edit update destroy]

  def index
    @business_profiles = BusinessProfile.accessible_by(current_ability).order(created_at: :desc)
  end

  def show
    @business_profile = BusinessProfile.find(params[:id])
    authorize! :read, @business_profile
  end

  def new
    @business_profile = BusinessProfile.new
    authorize! :create, @business_profile
  end

 def create
  @business_profile = BusinessProfile.new(business_profile_params)
  @business_profile.user = current_user  # assign the current logged-in user
  authorize! :create, @business_profile
  if @business_profile.save
    redirect_to admin_business_profile_path(@business_profile), notice: 'Business profile was successfully created.'
  else
    render :new
  end
end


  def edit
    authorize! :update, @business_profile
  end

  def update
    authorize! :update, @business_profile
    if @business_profile.update(business_profile_params)
      redirect_to admin_business_profile_path(@business_profile), notice: 'Business profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @business_profile
    @business_profile.destroy
    redirect_to admin_business_profiles_path, notice: 'Business profile was successfully deleted.'
  end

  private

  def set_business_profile
    @business_profile = BusinessProfile.find(params[:id])
  end

  def business_profile_params
    params.require(:business_profile).permit(
      :company_name, :business_type, :contact_info, :approval_status)
  end
end
