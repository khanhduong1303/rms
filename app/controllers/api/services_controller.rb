class Api::ServicesController < Api::ApiController
  before_action :set_service, only: [:show]
  before_action :set_services, only: [:index]
  skip_before_action :authenticate_user_from_token!

  def index
    unless @services.nil?
      render json: {status: 'success', message: 'Found services', total: @services.length, data: @services}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found services', data: {}}, status: :not_found
    end
  end

  def show
    unless @service.nil?
      render json: {status: 'success', message: 'Found service', data: @service}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found service', data: {}}, status: :not_found
    end
  end

  private
    def set_service
      begin
        @service = Service.select(:name, :image_path_file_name, :description, :call_to_order, :email, :more_info).find(params[:service_id])
      rescue ActiveRecord::RecordNotFound => e
        @service = nil
      end
    end

    def set_services
      begin
        @services = Service.select(:id, :name, :icon_path_file_name).where(service_category_id: params[:service_category_id])
      rescue Exception => e
        @services = nil
      end
    end
end

