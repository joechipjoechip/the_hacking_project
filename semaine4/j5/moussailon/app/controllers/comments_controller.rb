class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    new_comment = Comment.new(params_allowed)
    new_comment.mousaillon_id = params[:comment_come_from]
    new_comment.gossip_id = params[:goss_key]
    new_comment.save
    puts params
    redirect_to gossip_path(new_comment.gossip_id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def params_allowed
    params.require(:comment).permit(:body)
  end
end
