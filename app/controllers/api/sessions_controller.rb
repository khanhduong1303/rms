class Api::SessionsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [:destroy]
  before_filter :ensure_params_exist, :only => [:create]

  respond_to :json

  skip_before_filter :verify_authenticity_token

  # def create
  #   build_resource
  #   resource = User.find_for_database_authentication(
  #     email: params[:user][:email]
  #   )
  #   return invalid_login_attempt unless resource

  #   if resource.valid_password?(params[:user][:password])
  #     sign_in("user", resource)
  #     render json: {
  #       status: "success",
  #       message: "You sign in successfuly",
  #       result:{
  #         auth_token: resource.authentication_token,
  #         email: resource.email
  #              }
  #     }
  #     return
  #   end
  #   invalid_login_attempt
  # end
<<<<<<< HEAD
  def create

=======
    def sign_in
    
>>>>>>> e37345009a73b041c1f98b2b7311d8962befa4e2
    user = User.find_for_database_authentication(
        email: params[:user][:email]
    )
    return invalid_login_attempt unless user

    if user.valid_password?(params[:user][:password])
      # sign_in("user", resource)
      render json: {
          status: "success",
          message: "You sign in successfuly",
          result: {
              authentication_token: user.authentication_token,
              email: user.email
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
  #   render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
  # end
  def sign_out
    user = User.where(:authentication_token => params[:authentication_token]).first
    if user
      user.authentication_token= nil
      user.save
      render json: {
          status: "success",
          message: "You sign out successfuly, Seession is deleted ",
          result: {

          }
      }
    else
      render json: {
          status: "fails",
          message: "You need sign in or sign up first",
          result: {

          }
      }
    end
  end


  protected

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {
        success: false,
        message: "missing user parameter"
    }, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: {
        success: false,
        message: "Error with your login or password"
    }, status: 401
  end
end