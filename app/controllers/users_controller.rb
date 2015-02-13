class UsersController < ApplicationController
  before_filter :set_user, except: [:index]

  def welcome; end

  def index; end

  def show; end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      UserMailer.welcome_email(@user).deliver
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def current_user=(user)
    @current_user = user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
