class SessionsController < ApplicationController
  layout 'login'

  def new
    redirect_back_or_to_root if current_user
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    sign_in(user)
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
