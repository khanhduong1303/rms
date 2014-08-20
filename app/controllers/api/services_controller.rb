class Api::ServicesController < Api::ApiController

  skip_before_action :authenticate_user_from_token!

  def index
      begin
        services = Service.where(service_category_id: params[:service_category_id])
      rescue Exception => e
        services = nil
      end
      results = []
     services.each do |s| 
     results << {id: s.id , name: s.name ,image_path: s.image_path.url , icon_path: s.icon_path.url , description: s.description , call_to_order: s.call_to_order , address: s.address , email: s.email , web_page: s.web_page , term: s.term }
     end
    unless services.nil?
      render json: {status: 'success', message: 'Found services', total: services.length, results: results}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found services', results: {}}, status: :not_found
    end
  end

  def show
    s = Service.find(params[:service_id])
    unless s.nil?
      results = {id: s.id , name: s.name ,order_hours: s.order_hours ,image_path: s.image_path.url , icon_path: s.icon_path.url , description: s.description , call_to_order: s.call_to_order , address: s.address , email: s.email , web_page: s.web_page , term: s.term }
      render json: {status: 'success', message: 'Found service', results: results}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found service', results: {}}, status: :not_found
    end
  end




end

