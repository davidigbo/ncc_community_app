class Admin::EventRegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def set_registration
    @registration = EventRegistration.find(params[:id])
  end
  def index
    @event_registrations = EventRegistration.accessible_by(current_ability).order(created_at: :desc)
  end

  def show
    authorize! :read, @registration
  end

  def new
    @registration = EventRegistration.new
    authorize! :create, @registration
  end

  def create
    @registration = EventRegistration.new(event_registration_params)
    authorize! :create, @registration
    if @registration.save
      redirect_to admin_event_registrations_path, notice: 'Registration created successfully.'
    else
      render :new
    end
  end

  def edit
    authorize! :update, @registration
  end

  def update
    authorize! :update, @registration
    if @registration.update(event_registration_params)
      redirect_to admin_event_registrations_path, notice: 'Registration updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @registration
    @registration.destroy
    redirect_to admin_event_registrations_path, notice: 'Registration deleted successfully.'
  end

  private

  def set_registration
    @registration = EventRegistration.find(params[:id])
  end

  def event_registration_params
    params.require(:event_registration).permit(:user_id, :event_id, :status)
  end
end
