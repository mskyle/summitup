class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authorize

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:user_name, :email, :first_name, :last_name, :current_password, :image) }
  end

  def authorize
    if !current_permission.allow?(params[:controller], params[:action])
      redirect_to root_url, alert: "Not authorized"
    end  
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

end
