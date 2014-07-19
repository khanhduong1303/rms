class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :change_active, :confirm, :destroy]
  before_action :set_facilities, only: [:index, :create, :update, :destroy]
  before_action :set_hightlight
  respond_to :json ,:html, :js

  def index
  end

  def new
    @facility = Facility.new
    @cat = current_user.condo.facility_categories
  end

  def create
    @facility = Facility.create(facility_params)
  end

  def edit
    @cat = current_user.condo.facility_categories
  end

  def update
    if params[:facility][:image]
      @image = true
    else
      @image = false
    end
    @facility.update_attributes(facility_params)
  end

  def change_active
    begin
      @facility.active = params[:active]
      @facility.save
      render json: { status: 'success' }
    rescue Exception => e
      render json: { status: 'failed' }
    end
  end

  def confirm
  end

  def destroy
    @facility.destroy
  end

  private
    def set_facility
      @facility = Facility.find(params[:id])
    end

    def set_facilities
      @facilities = current_user.condo.facilities
    end

    def facility_params
      params.require(:facility).permit(:name, :booking_price, :deposit_price, :note, :image, :facility_category_id)
    end

    def set_hightlight
      session[:menustatus] = 'facilities'
    end
end

