class GuardHouseImagesController < ApplicationController
  before_action :set_guard_house_image, only: [:edit]
  before_action :set_guard_house_images, only: [:index, :create, :update, :destroy]
  respond_to :html, :js, :json

  def index
  end

  def new
    @guard_house_image = GuardHouseImage.new
  end

  def create
    @guard_house_image = GuardHouseImage.create(guard_house_image_params)
  end

  def edit
  end

  def update
    @guard_house_image.update_attributes(guard_house_image_params)
  end

  def destroy
  end

  private
  def set_guard_house_image
    @guard_house_image = GuardHouseImage.find(params[:id])
  end

  def set_guard_house_images
    @guard_house_images = current_user.condo.guard_house_images
  end

  def guard_house_image_params
    params.require(:guard_house_image).permit(:name, :image_path, :guard_house_id)
  end
end

