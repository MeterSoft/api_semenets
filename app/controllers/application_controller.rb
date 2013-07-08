class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :admin?
  helper_method :connection

  before_filter :authenticate!

  def current_user
    @current_user ||= session[:current_user] if session[:current_user]
  end

  def authorized?
    !!current_user
  end

  def admin?
  	current_user['role'] == 'admin'
  end

  def connection
  	@api2_connection ||= Faraday.new(:url => 'http://grape-server.herokuapp.com') do |faraday|
      faraday.request  :url_encoded             
      faraday.response :logger                  
      faraday.adapter  Faraday.default_adapter 
    end
  end

  def get_request(url, data, method)
  	resp = connection.send(method) do |req|
	  req.url url
	  req.body = data
	end

	@rez = JSON.parse(resp.body)
  end

  private

  def authenticate!
  	redirect_to new_session_path unless authorized?
  end
end
