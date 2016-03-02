class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def must_be_logged_in
    unless current_user
      redirect_to login_path, notice: "please log in"
    end
  end
  
end
