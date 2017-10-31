class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:danger] = "NOPE"
      render 'index'
    end
  end

  def new
    @user = User.new
  end

  def create
  end

  def update
  end

  def destroy
  end
end
