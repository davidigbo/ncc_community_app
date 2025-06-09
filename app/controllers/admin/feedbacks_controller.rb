class Admin::FeedbacksController < ApplicationController
  before_action :set_event
  before_action :set_feedback, only: %i[show update destroy]

  def index
    @feedbacks = @event.feedbacks.includes(:user).order(created_at: :desc)
    authorize! :read, Feedback
  end
  
  def show
    @feedback = @event.feedbacks.find(params[:id])
    @replies = @feedback.replies.includes(:user)
    authorize! :read, @feedback
  end

  def new
  @event = Event.find(params[:event_id])
  @feedback = @event.feedbacks.build
  authorize! :new, @feedback
end


  def create
    @feedback = @event.feedbacks.new(feedback_params)
    @feedback.user = current_user
    authorize! :create, @feedback

    if @feedback.save
      redirect_to admin_event_feedbacks_path(@event, @feedback), notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

 def update
    @feedback = @event.feedbacks.find(params[:id])
    authorize! :update, @feedback
    if @feedback.update(feedback_params)
      redirect_to admin_event_feedbacks_path(@event), notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    @feedback = @event.feedbacks.find(params[:id])
    authorize! :edit, @feedback
  end

  def destroy
    @feedback.destroy
    authorize! :destroy, @feedback
    redirect_to admin_event_feedbacks_path(@event), notice: 'Feedback was successfully deleted.'
  end
  
  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:user_id, :event_id, :content, :status)
  end
end
