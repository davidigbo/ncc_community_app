class Admin::FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show destroy]

  def index
    @feedbacks = Feedback.accessible_by(current_ability).order(created_at: :desc)
  end

  def show
    authorize! :read, @feedback
  end

  def new
    @feedback = Feedback.new
    authorize! :new, @feedback
  end

  def create
    @feedback = Feedback.new(feedback_params)
    authorize! :create, @feedback
    if @feedback.save
      redirect_to admin_feedbacks_path, notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

  def destroy
    authorize! :destroy, @feedback
    @feedback.destroy
    redirect_to admin_feedbacks_path, notice: 'Feedback was successfully deleted.'
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:user_id, :event_id, :content, :status)
  end
end
