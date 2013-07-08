class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def new
  end

  def create
    resp = connection.get do |req|
	  req.url '/api/sessions'
	  req.body = params[:user]
	end
	
	rez = JSON.parse(resp.body)	


	if rez['error'].present?
	  flash[:error] = rez['error']
	  redirect_to new_session_path
	else
	  session[:current_user] = rez
	  flash[:notice] = "You login as #{current_user['role']}"
	  redirect_to admin? ? admin_pages_path : content_provider_pages_path
	end
  end

  def destroy
  	session[:current_user] = nil
    redirect_to new_session_path
  end
end
