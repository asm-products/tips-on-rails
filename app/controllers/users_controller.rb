class UsersController < ApplicationController
  before_filter :set_user, except: [:index]

  def welcome; end

  def index; end

  def show; end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'Profile updated'
    else
      render :edit
    end
  end

  private

  attr_writer :current_user

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
