class GossipsController < ApplicationController
  def index
    @allGoss = Gossip.all
    @allMous = Mousaillon.all
    @allCom = Comment.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @allMous = Mousaillon.all
    @new_comment = Comment.new
    @all_comments_of_this_gossip = Comment.where(:gossip_id => params[:id])
  end

  def new
    @new_gossip = Gossip.new
    @this_mousaillon = Mousaillon.find(params[:mous_id])
  end

  def create
    new_gossip = Gossip.new(params_allowed)
    new_gossip.mousaillon_id = params[:mous_key]
    new_gossip.save
    redirect_to mousaillon_path(new_gossip.mousaillon_id)
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    gossip_to_up = Gossip.find(params[:id])
    gossip_to_up.update(params_allowed)
    redirect_to gossip_path(gossip_to_up.id)
  end

  def destroy
    gossip_to_destroy = Gossip.find(params[:id])
    gossip_to_destroy.destroy
    redirect_to gossips_path
  end

  private
  def params_allowed
    params.require(:gossip).permit(:mousaillon_id, :body)
  end
end
