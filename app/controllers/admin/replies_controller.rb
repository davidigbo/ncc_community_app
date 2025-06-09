class Admin::RepliesController < ApplicationController
    before_action :set_feedback
    before_action :set_event
    before_action :authenticate_admin_or_moderator!
    before_action :set_reply, only: %i[show edit update destroy]

  def index
      @replies = @feedback.replies.includes(:user).order(created_at: :desc)
  end


  def show
  end

  def new
    @reply = @feedback.replies.new
  end

  def create
    @reply = @feedback.replies.new(reply_params)
    @reply.user = current_user

      if @reply.save
      redirect_to admin_event_feedback_path(@event, @feedback), notice: "Reply was successfully created."
    else
      render :new
    end
  end

  def edit
    @reply = @feedback.replies.find(params[:id])
    unless @reply.user == current_user || current_user.admin?
      redirect_to admin_event_feedback_replies_path(@event, @feedback), alert: "You are not authorized to edit this reply."
      return
     end
  end

 def update
    @reply = @feedback.replies.find(params[:id])
    if @reply.update(reply_params)
      redirect_to admin_event_feedback_replies_path(@event, @feedback), notice: "Reply updated."
    else
      render :edit
    end
  end

  def destroy
    @reply = @feedback.replies.find(params[:id])
    @reply.destroy
    redirect_to admin_event_feedback_replies_path(@event, @feedback), notice: "Reply deleted."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_feedback
    @feedback = @event.feedbacks.find(params[:feedback_id])
  end

   def reply_params
    params.require(:reply).permit(:content)
  end
end
