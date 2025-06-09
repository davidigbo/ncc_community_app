class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:name)
  end

  def show
    authorize! :read, @user
  end

  def new
    @user = User.new
    authorize! :create, @user
  end

  def create
    @user = User.new(user_params)
    authorize! :create, @user
    if @user.save
      redirect_to admin_users_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated successfully.'
    else
      render :edit
    end 
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :bio, :avatar)
  end

  def ensure_admin_or_moderator!
    unless current_user.admin? || current_user.moderator?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
