class SessionsController < ApplicationController

before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def logout
  	session[:user_id] = nil
  	redirect_to :action => 'login'
  end


  def login_attempt
    authorized_user = User.authenticate(params[:username],params[:login_password])
	if authorized_user
    	session[:user_id] = authorized_user.id
    	flash[:notice] = "Welcome again, you logged in as #{authorized_user.name}"
    	redirect_to root_url
	else
    	flash[:notice] = "Invalid Username or Password"
    	flash[:color]= "invalid"
	    render "login"	
  	end
  end
end
