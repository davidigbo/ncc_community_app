class Admin::EventsController < ApplicationController
  def index
    @events = Event.accessible_by(current_ability).order(created_at: :desc)
  end

  def show
    authorize! :read, @event
  end

  def def new
    @event = Event.new
    authorize! :create, @event
  end
  
  def create
    @event = Event.new(event_params)
    authorize! :create, @event
    if @event.save
      redirect_to admin_event_path(@event), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize! :update, @event
  end

  def update
    authorize! :update, @event
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @event
    @event.destroy
    redirect_to admin_events_path, notice: 'Event was successfully deleted.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :location, :status)
  end
end
