class Api::ServiceCategoriesController < Api::ApiController
  skip_before_action :authenticate_user_from_token!
  def index
    begin
      service_categories = ServiceCategory.where(condo_id: params[:condo_id])
    rescue Exception => e
      service_categories = nil
    end
    result = []
service_categories.each do |s|
  result << {name: s.name , icon_path: s.icon_path.url , id: s.id}
end
    unless service_categories.nil?
      render json: {status: 'success', message: 'Found service categories', total: service_categories.length, results: result }, status: :ok
    else
      render json: {status: 'failed', message: 'Not found service categories', results: {}}, status: :not_found
    end
  end
end

