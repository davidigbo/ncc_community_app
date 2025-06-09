class Admin::EventRegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_registration, only: [:edit, :update, :destroy]

  def index
    @event = Event.find(params[:event_id])
    @registrations = EventRegistration.includes(:event).where(event_id: params[:event_id])
    authorize! :read, @registrations
  end

  def show
    authorize! :read, @registration
  end
def new
  @event = Event.find(params[:event_id])
  @registration = @event.event_registrations.build(registration_date: Date.today)
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
    @event = Event.find(params[:event_id])
    @registration = @event.event_registrations.find(params[:id])
    authorize! :update, @registration
  end

  def update
  @event = Event.find(params[:event_id])
  @registration = @event.event_registrations.find(params[:id])

  if @registration.update(event_registration_params)
    redirect_to admin_event_event_registrations_path(@event), notice: "Registration updated successfully."
  else
    render :edit
  end
end

private

  def destroy
    authorize! :destroy, @registration
    @registration.destroy
    redirect_to admin_event_registrations_path, notice: 'Registration deleted successfully.'
  end

  private

  def set_registration
    @registration = EventRegistration.find(params[:id])
  end

  def set_event 
    @event = Event.find(params[:event_id])
  end

  def event_registration_params
    params.require(:event_registration).permit(:name, :email, :phone_number, :location, :profession, :user_id, :event_id, :registration_date, :notes)
  end
end
