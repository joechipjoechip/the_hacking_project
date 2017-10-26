class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    # équivalent du binding.pry :
    # debugger
  end

  def edit
  end

  def destroy
  end

  def create
  end

  def new
  end
end
