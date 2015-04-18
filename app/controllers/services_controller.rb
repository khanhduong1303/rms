class ServicesController < ApplicationController
    respond_to :json, :html, :js
    authorize_resource
  def index
    @services = Service.where(user_id: current_user.id)
  end 
  def show
    @service = Service.find(params[:id])
  end 
  def edit
    @service = Service.find(params[:id])
    @service_categories = current_user.condo.service_categories
  end 
  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    @services = Service.where(user_id: current_user.id) 
  end 
  def new 
    @service = Service.new
    @service_categories = current_user.condo.service_categories
  end 
  def create 
    @service = Service.create(service_params)
    @services = Service.where(user_id: current_user.id)

  end 
  def confirm
     @service = Service.find(params[:id])
  end
  def update
    @service = Service.find(params[:id])
    @service.update(service_params)
    @services = Service.where(user_id: current_user.id)
  end   
  def service_params
    params.require(:service).permit(:our_menu, :name,:call_to_order, :address,:description,:term ,:web_page ,:email,:order_hours , :image_path, :service_category_id , :user_id)
  end

end
