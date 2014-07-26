class GuardHousesController < ApplicationController
  before_action :set_guard_house, only: [:index, :edit, :update]
  before_action :set_guard_houses, only: [:update]
  before_action :set_highlight
  respond_to :html, :js, :json

  def index
#    @guard_house_images = current_user.condo.guard_house_images
  end

  def edit
  end

  def update
    @guard_house.update_attributes(guard_house_params)
  end

  private
    def set_guard_house
      @guard_house = GuardHouse.find_by_condo_id(current_user.condo.id)
    end

    def set_guard_houses
      @guard_houses = current_user.condo.guard_houses
    end

    def guard_house_params
      params.require(:guard_house).permit(:phone, :photo_path, :map_path, :condo_id)
    end

    def set_highlight
      session[:menustatus] = 'guard_houses'
    end
end

