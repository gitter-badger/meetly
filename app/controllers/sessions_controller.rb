class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    sign_in(user)
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
