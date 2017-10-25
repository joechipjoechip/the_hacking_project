class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def edit
    @goss = Gossip.find(params[:id])
  end

  def new
    @new_gossip = Gossip.new
  end

  def create
    gossip_to_create = Gossip.create(params_allowed)
    redirect_to gossip_path(gossip_to_create.id)
  end

  def update
    gossip_to_update = Gossip.find(params[:id])
    gossip_to_update.update(params_allowed)
    redirect_to gossip_path(gossip_to_update.id)
  end

  def destroy
    gossip_to_del = Gossip.find(params[:id])
    gossip_to_del.destroy
    redirect_to root_url
  end

  private
  def params_allowed
    params.require(:gossip).permit(:content, :anonymous_author)
  end


end
