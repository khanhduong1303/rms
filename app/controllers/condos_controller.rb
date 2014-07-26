class CondosController < ApplicationController
  before_action :set_hightlight
  respond_to :json, :html, :js

  def index
    @condo = current_user.condo

  end

  def edit
    @condo_image = CondoImage.new
    @condo = Condo.find(params[:id])
  end

  def update

    @condo = Condo.find(params[:id])
    if @condo.update(condo_params)
      if params[:image_id]
        params[:image_id].each do |image_id|
          CondoImage.find(image_id).destroy
        end
      end

      redirect_to condos_path, notice: 'Event was successfully updated.'


    else
      render :edit

    end

  end

  def create_image

    @condo = current_user.condo
    @flag = false
    if params[:condo_image]
      params[:condo_image][:image].each { |image|
        @condo.condo_images.create(image: image)
      }
      @flag = true
    else
      @flag = false
    end
    # CondoImage.create(params.require(:condo_image).permit(:image, :condo_id))
    # 	 redirect_to condos_path

  end

  def set_hightlight
    session[:menustatus] = 'condoInfos'
  end

  def condo_params
    params.require(:condo).permit(:name, :property_type, :developer, :num_of_units, :tenure, :top_year, :property_type, :description)
  end
end
