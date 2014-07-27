class GuardHouseImagesController < ApplicationController
  before_action :set_guard_house_image, only: [:edit, :update, :show]
  before_action :set_guard_house_images, only: [:index, :create, :destroy]
  include ActionController::MimeResponds

  def index
  end

  def new
    @guard_house_image = GuardHouseImage.new
  end

  def show

  end
  def create
    @guard_house_image = GuardHouseImage.create(guard_house_image_params)
  end

  def edit
  end

  def update
    if params[:guard_house_image][:name].blank?
      if @guard_house_image.update_attributes(name:'No content!')
        render json: @guard_house_image
      else
        render json: @guard_house_image
      end
    else
      if @guard_house_image.update(guard_house_image_params)
        render json: @guard_house_image
      else
        render json: @guard_house_image
      end
    end

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

