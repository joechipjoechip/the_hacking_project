class MousaillonsController < ApplicationController
  def index
    @mousaillons = Mousaillon.all
  end

  def show
    @mousaillon = Mousaillon.find(params[:id])
    @his_gossips = Gossip.where(:mousaillon_id => @mousaillon.id)
    @allCom = Comment.all
  end

  def new
    @new_mousaillon = Mousaillon.new
  end

  def create
    new_mous = Mousaillon.create(params_allowed)
    redirect_to mousaillon_path(new_mous.id)
  end

  def edit
    @mousaillon = Mousaillon.find(params[:id])
  end

  def update
    mousaillon_to_up = Mousaillon.find(params[:id])
    mousaillon_to_up.update(params_allowed)
    redirect_to mousaillon_path(mousaillon_to_up.id)
  end

  def destroy
    mous_to_destroy = Mousaillon.find(params[:id])
    mous_to_destroy.destroy
    redirect_to mousaillons_path
  end

  private
  def params_allowed
    params.require(:mousaillon).permit(:username, :email, :bio)
  end
end
