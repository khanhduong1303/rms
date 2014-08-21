class Api::ApiController < ActionController::Base
  respond_to :json
  before_filter :authenticate_user_from_token!

  def authenticate_user_from_token!
    user = User.find_by_authentication_token(params[:auth_token])
    unless user
      render json: {
          status: "false",
          message: "You need sign in/sign up to continue",
          results: {}
      }, status: 401
    end
  end
end

