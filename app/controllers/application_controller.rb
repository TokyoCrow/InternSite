class ApplicationController < ActionController::Base
  before_action :logged_in_user
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
end
