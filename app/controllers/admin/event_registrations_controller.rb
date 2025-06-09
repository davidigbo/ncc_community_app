class Admin::EventRegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.event_registrations
    authorize! :read, @registrations
  end

  def show
    authorize! :read, @registration
  end
def new
  @event = Event.find(params[:event_id])
  @registration = @event.event_registrations.build
end

def create
  @event = Event.find(params[:event_id])
  @registration = @event.event_registrations.build(event_registration_params)
  if @registration.save
    redirect_to admin_event_event_registrations_path(@event), notice: "Registration successful"
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
    params.require(:event_registration).permit(:name, :email, :phone_number, :location, :profession, :user_id, :event_id, :status, :registration_date, :notes)
  end
end
