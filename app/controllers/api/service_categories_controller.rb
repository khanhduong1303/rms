class Api::ServiceCategoriesController < Api::ApiController
  skip_before_action :authenticate_user_from_token!
  def index
    begin
      @service_categories = ServiceCategory.select(:id, :name, :icon_path_file_name).where(condo_id: params[:condo_id])
    rescue Exception => e
      @service_categories = nil
    end

    unless @service_categories.nil?
      render json: {status: 'success', message: 'Found service categories', total: @service_categories.length, data: @service_categories}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found service categories', data: {}}, status: :not_found
    end
  end
end

