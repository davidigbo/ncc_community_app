class Admin::BusinessProfilesController < ApplicationController
  before_action :set_business_profile, only: %i[show edit update destroy]

  def index
    @business_profiles = BusinessProfile.access_by(current_ability).order(created_at: :desc)
  end

  def show
    authorize! :read, @business_profile
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
    return unless @business_profile.approval_status == 'pending'
    flash[:alert] = 'Cannot delete a business profile that is pending approval.'
    return if @business_profile.approval_status == 'approved'
    return if @business_profile.approval_status == 'rejected'
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
