class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :set_user_language
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #  protect_from_forgery with: :exception
def after_sign_in_path_for(resource)
  homes_path
end
def routing_error
  raise ActionController::RoutingError.new(params[:path])
end
def render_not_found
  render :file => "#{Rails.root}/public/404.html", :status => 403, :layout => false
end
rescue_from ActionController::RoutingError, :with => :render_not_found  
rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        if current_user.nil? # user is unauthorized because he/she is not logged in
          session[:next] = request.fullpath
          redirect_to new_user_session_path, :alert => "Please log in to continue."
        else
          render :file => "#{Rails.root}/public/422.html", :status => 403, :layout => false         
        end
      end

      format.json do
       
        render json: { status: 403, message: "You are not allowed to access this resource." } , status: :forbidden
      end
      format.js do 
        render js: " window.location = '/422.html'"
       end 
    end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :phone, :condo_id, :postal_code, :enquiry, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username,
                                                                   :avatar, :email, :password,
                                                                   :password_confirmation,
                                                                   :current_password,
                                                                   :company, :name, :city, :country, :postal_code, :phone) }
  end

  private
  def set_user_language
    I18n.locale = 'vi'
  end

end

