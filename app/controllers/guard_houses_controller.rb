class GuardHousesController < ApplicationController
  before_action :set_guard_house, only: [:index, :edit, :update]
  #before_action :set_guard_houses, only: [:update]
  before_action :set_highlight
  respond_to :html, :js, :json

  def index
    @guard_house_images = current_user.condo.guard_house_images
  end

  def edit
  end

  def update
    @guard_house.update_attributes(guard_house_params)
  end

  def update_photo
    if GuardHouse.where(id:params[:guard_house_id]).size > 0
      @guard_house=GuardHouse.find(params[:guard_house_id])
      if params[:guard_house][:guard_house_image].size > 0
        params[:guard_house][:guard_house_image].each do |image|
          @guard_house.guard_house_images.create(:image_path=> image)
        end

      end
    end
    respond_to do |format|
      format.html {redirect_to guard_houses_path}
    end

  end

  private
  def set_guard_house
    @guard_house = GuardHouse.find_by_condo_id(current_user.condo.id)
  end

  def set_guard_houses
    params.require(:guard_house).permit(:phone, :photo_path, :map_path, :condo_id, :guard_house_image)
    @guard_houses = current_user.condo.guard_houses
  end

  def guard_house_params
    params.require(:guard_house).permit(:phone, :photo_path, :map_path, :condo_id, :guard_house_image)
  end

  def set_highlight
    session[:menustatus] = 'guard_houses'
  end
end

