class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  helper_method :current_person
  helper_method :current_account
  helper_method :user_signed_in?

  private

  def current_person
    User.find_by(id: session[:user_id])
  end

  def authorize_user
    return unless current_user.nil?
    session[:return_to] = request.url
    redirect_to login_path, notice: 'Please sign in!'
  end

  def user_signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    if user
      session[:user_id] = user.id
      redirect_to session.delete(:return_to) || root_path
    else
      flash.now[:error] = 'Wrong credentials'
      render :new
    end
  end
end
