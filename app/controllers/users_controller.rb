class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :non_signed_in_user, only: [:create, :new]
  before_action :correct_user, only: [:edit, :update]
  
  
  def new
  	@user = User.new
  end

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to Tips on Rails"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in_user
    redirect_to root_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user(@user)
  end

  def non_signed_in_user
    redirect_to root_url if signed_in?
  end
end