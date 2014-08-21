class Api::ServiceCategoriesController < Api::ApiController
  def index
    begin
      service_categories = ServiceCategory.where(condo_id: params[:condo_id])
    rescue Exception => e
      service_categories = nil
    end
    results = []
service_categories.each do |s|
  results << {name: s.name , icon_path: s.icon_path.url , id: s.id}
end
    unless service_categories.nil?
      render json: {status: 'success', message: 'Found service categories', total: service_categories.length, results: results }, status: :ok
    else
      render json: {status: 'failed', message: 'Not found service categories', results: {}}, status: :not_found
    end
  end
end

