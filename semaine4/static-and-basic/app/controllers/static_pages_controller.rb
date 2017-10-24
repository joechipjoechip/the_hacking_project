class StaticPagesController < ApplicationController
  def home
  end

  def contact
  end

  def about
    # puts params.inspect
    if params[:name]
      @name = params[:name].capitalize
    else
      @name = 'Jean-Claude Dus'
    end
  end
end
