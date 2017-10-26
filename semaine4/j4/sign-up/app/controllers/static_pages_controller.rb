class StaticPagesController < ApplicationController
  def index
  end

  def about
    @name = params[:name]
  end
end
