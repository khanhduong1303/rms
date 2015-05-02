class Api::SessionsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [:destroy]
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def sign_in
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless user

    if user.valid_password?(params[:password])
      render json: {
          status: 'success',
          message: 'You sign in successfuly',
          results: {
              user_id: user.id,
              email: user.email,
              name: user.name,
              username: user.username,
              auth_token: user.authentication_token,
              condo_id: user.condo.id
          }
      }
      return
    end
    invalid_login_attempt
  end

  def sign_out
    user = User.find_by(authentication_token: params[:auth_token])
    if user
      user.authentication_token = nil
      user.save
      render json: {
          status: 'success',
          message: 'You sign out successfuly, Session is deleted ',
          results: {}
      }
    else
      render json: {
          status: 'failed',
          message: 'You need sign in or sign up first',
          results: {}
      }
    end
  end

  protected
    def invalid_login_attempt
      warden.custom_failure!
      render json: {
          status: 'failed',
          message: 'Error with your login or password',
          results: {}
      }
    end
end

