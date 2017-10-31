class SessionsController < ApplicationController
  def new
  end

  def create
    # sessionParams = params_allowed
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])

      flash[:notice] = 'on est bon !'
      log_in(user)
      redirect_to user
      # is the same as -> redirect_to user_url(user)
      # is the same as -> redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end

  end

  def destroy
  end

  private
  def params_allowed
    params.require(:session).permit(:email, :password)
  end
end
