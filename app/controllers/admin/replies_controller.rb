class Admin::RepliesController < ApplicationController
      before_action :set_reply, only: %i[show edit update destroy]

  def index
    @replies = Reply.includes(:feedback, :user).order(created_at: :desc)
  end

  def show
  end

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      redirect_to admin_reply_path(@reply), notice: "Reply was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      redirect_to admin_reply_path(@reply), notice: "Reply was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reply.destroy
    redirect_to admin_replies_path, notice: "Reply was successfully deleted."
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:feedback_id, :user_id, :content)
  end
end

