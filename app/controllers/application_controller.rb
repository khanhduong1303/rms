class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_user_language
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #  protect_from_forgery with: :exception
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

