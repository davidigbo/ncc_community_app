class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.accessible_by(current_ability).order(created_at: :desc)
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
    authorize! :update, @user
  end

  def update
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
end
