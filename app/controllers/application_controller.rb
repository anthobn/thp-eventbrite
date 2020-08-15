class ApplicationController < ActionController::Base
  before_action :configure_devise_parameters, if: :devise_controller?

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:first_name, :last_name, :email, :description, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name, :last_name, :email, :description, :password, :password_confirmation, :current_password)}
  end
  
  def is_admin_of_event?
    if params[:id]
      event = Event.find(params[:id])
    else
      return false
    end
    
    if current_user == event.user_admin
      return true
    else
      flash[:error] = "Vous n'avez pas l'autorisation d'effectuer cette action"
      redirect_to root_path
    end
  end
end
