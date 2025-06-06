class Admin::FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show destroy]

  def index
    @feedbacks = Feedback.accessible_by(curret_ability).oder(created_at: :desc)
  end

  def show
    authorize! :read, @feedback
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
end
