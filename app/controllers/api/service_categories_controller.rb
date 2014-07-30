class Api::ServiceCategoriesController < Api::ApiController

  def index
    begin
      @service_categories = ServiceCategories.where(condo_id: params[:condo_id])
    rescue Exception => e
      @service_categories = nil
    end

    unless @service_categories.nil?
      render json: {status: 'success', message: 'Found service categories', total: @service_categories.size, data: @service_categories}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found service categories', data: {}}, status: :not_found
    end
  end
end

