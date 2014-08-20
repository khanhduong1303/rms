class ServicesController < ApplicationController
    respond_to :json, :html, :js
  def index
    @services = Service.where(user_id: current_user.id)
  end 
  def show
    @service = Service.find(params[:id])
  end 
  def edit
  end 
  def destroy
  end 
  def new 
   @service = Service.new
    @service_categories = current_user.condo.service_categories
  end 
  def create 
    @service = Service.create(service_params)

  end 
  def update
  end   
  def service_params
    params.require(:service).permit(:name,:call_to_order, :address,:description,:term ,:web_page ,:email,:order_hours , :image_path, :service_category_id , :user_id)
  end
end
