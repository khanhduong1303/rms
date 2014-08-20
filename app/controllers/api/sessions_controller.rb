class Api::SessionsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [:destroy]
  skip_before_filter :verify_authenticity_token
  respond_to :json

  # def create
  #   build_resource
  #   resource = User.find_for_database_authentication(
  #     email: params[:email]
  #   )
  #   return invalid_login_attempt unless resource

  #   if resource.valid_password?(params[:password])
  #     sign_in('user', resource)
  #     render json: {
  #       status: 'success',
  #       message: 'You sign in successfuly',
  #       data:{
  #         auth_token: resource.authentication_token,
  #         email: resource.email
  #              }
  #     }
  #     return
  #   end
  #   invalid_login_attempt
  # end

  def sign_in
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless user

    if user.valid_password?(params[:password])
      render json: {
          status: 'success',
          message: 'You sign in successfuly',
          data: {
              user_id: user.id,
              email: user.email,
              name: user.name,
              token: user.authentication_token,
              condo_id: user.condo.id
          }
      }
      return
    end
    invalid_login_attempt
  end

  # def destroy
  #     user = User.where(:authentication_token => params[:authentication_token]).first
  #     user.authentication_token= nil
  #     user.save
  #   render :json => { :message => ['Session deleted.'] },  :success => true, :status => :ok
  # end
  def sign_out
    user = User.where(:authentication_token => params[:authentication_token]).first
    if user
      user.authentication_token = nil
      user.save
      render json: {
          status: 'success',
          message: 'You sign out successfuly, Session is deleted ',
          data: {}
      }
    else
      render json: {
          status: 'failed',
          message: 'You need sign in or sign up first',
          data: {}
      }
    end
  end

  protected
    def invalid_login_attempt
      warden.custom_failure!
      render json: {
          status: 'failed',
          message: 'Error with your login or password',
          data: {}
      }
    end
end

