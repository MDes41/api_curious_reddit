class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :make_sure_user_is_logged_in

  helper_method :current_user

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def make_sure_user_is_logged_in
  # 	if session[:user_id] == nil
  # 		flash[:danger] = "Please login to view data"
  		
  # 	render_template 'public/404.html' if session[:user_id] == nil
  # end
end
