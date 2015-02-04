class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  
  before_action :authenticate_user!, except: [:new, :create]







 
  


  protected

 


  def after_sign_up_path_for(resource)
    new_charge_path
  end

  def configure_permitted_parameters
    
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :plan
    devise_parameter_sanitizer.for(:sign_up) << :school
    devise_parameter_sanitizer.for(:sign_up) << :position
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :extra_access
  end
end