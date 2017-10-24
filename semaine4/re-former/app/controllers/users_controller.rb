class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params_allowed)
    # puts params.inspect

    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(params_allowed)
    redirect_to user_path(user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  def params_allowed
    params.require(:user).permit(:username, :email, :bio)
  end


end
