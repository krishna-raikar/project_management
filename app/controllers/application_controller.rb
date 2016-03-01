class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  #for including cancancan controller methods
  include CanCan::ControllerAdditions  
  
  protect_from_forgery with: :exception

  before_action :auth_user,:except=>[:welcome]

  def auth_user
    if self.controller_name.eql?("promax")
      # raise "e".inspect
        return
    else 
        authenticate_user!
    end
  end
  

  def after_sign_in_path_for(resource_or_scope)
     "/promax"
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) do |u|
  		u.permit(:firstname,:lastname,:email,:password,:role_id,:phone,:password_confirmation, :remember_me)
  	end

  	devise_parameter_sanitizer.for(:account_update) do |u|
  		u.permit(:firstname,:lastname,:email,:password,:role_id,:phone,:password_confirmation, :remember_me,:current_password)
  	end
  end



   # rescue_from ActiveRecord::RecordNotFound,
   #              ActionController::RoutingError,
   #              ActionController::UnknownController,
   #              # ActionController::UnknownAction,
   #              ActionController::MethodNotAllowed do |exception|

   #    # Put loggers here, if desired.

   #    render(:status => 404)
   #  end
  
  #for handling exception occured from cancancan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/"+params[:controller] , :alert => exception.message
  end

end
