class Api::CondosController < ActionController::Base
  respond_to :json
  before_filter :find_project, :only => [:show, :update, :destroy]
#  before_filter :authenticate_user_from_token!

  def list

    condo = Condo.all
    result = condo.collect { |c| {:id => c.id, :name => c.name} }
    render json: {
        status: "success",
        message: "List Condo",
        result: result

    }

  end

  def show
    render json: {
        status: "success",
        message: "Condo Detaile",
        result: @condo

    }
  end


  def find_project
    @condo = Condo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
        status: "false",
        message: "The condo you were looking is not be found",
        result: {}

    }

  end

  private
  def authenticate_user_from_token!
    user = User.find_by_authentication_token(params[:authentication_token])
    unless user
      render json: {
          status: "false",
          message: "You need sign in/sign up to continue",
          result: {}

      }, status: 401
    end


  end


end

