class Api::CondosController < Api::ApiController
  before_filter :find_project, :only => [:show, :update, :destroy]
  skip_before_filter :authenticate_user_from_token! , :only => [:list]

  def list
    condo = Condo.all
    results = condo.collect { |c| {:id => c.id, :name => c.name} }
    render json: {
        status: "success",
        message: "List Condo",
        results: results
    }
  end

  def show
    render json: {
        status: "success",
        message: "Condo Detaile",
        results: @condo
    }
  end

  def find_project
    @condo = Condo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
        status: "false",
        message: "The condo you were looking is not be found",
        results: {}
    }
  end
end

