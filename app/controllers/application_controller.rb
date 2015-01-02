class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protected

  def after_sign_in_path_for(resource)
    lessons_path
  end

  def require_admin
    if user_signed_in?
      unless current_user.admin?
        flash[:error] = "Only admins are allowed to see this page"
        redirect_to root_path
      end
    else
      flash[:error] = "Only admins are allowed to see this page"
      redirect_to root_path
    end
  end

  # def configure_permitted_parameters
  #   # devise_parameter_sanitizer.for(:sign_up) << :stripe_card_token
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  #   devise_parameter_sanitizer.for(:account_update) << :name
  # end
end