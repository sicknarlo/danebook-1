class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if user_params[:password] == user_params[:password_confirmation]
      if @user.save
        sign_in(@user)
        flash[:success] = "New User Created!"
        redirect_to user_path
      else
        flash[:error] = "An Error Has Occurred."
        render :new
      end
    else
      flash[:error] = "Passwords much match"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :id)
  end

end