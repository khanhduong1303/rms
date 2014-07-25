class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :change_active, :confirm, :destroy]
  before_action :set_facilities, only: [:index, :create, :update, :destroy]
  before_action :set_hightlight
  respond_to :json ,:html, :js

  def index
  end

  def new
    @facility = Facility.new
    @facility_categories = current_user.condo.facility_categories
  end

  def create
    @facility = Facility.create(facility_params)
    @persisted = false
  end

  def edit
    @facility_categories = current_user.condo.facility_categories
  end
  def timeslot
    @facility = Facility.find(params[:facility_id])
    @timeslots =   @facility.time_slots
    @timeslot = TimeSlot.new

  end
   def add_timeslot
    @timeslot = TimeSlot.create(timeslot_params)
     @facility = Facility.find(params[:time_slot][:facility_id])
     @timeslots =   @facility.time_slots

  end

  def update
    @facility.update_attributes(facility_params)
    @persisted = true
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

  def change_peak
     @timeslot = TimeSlot.find(params[:id])
     @timeslot.peak = params[:peak]
     @timeslot.save
     render json: {peak: @timeslot.peak }
  end


  def destroy
    @facility.destroy
  end

  private
    def set_facility
      @facility = Facility.find(params[:id])
    end
  def timeslot_params
      params.require(:time_slot).permit(:slot_start, :slot_end, :facility_id)
  end

    def set_facilities
      @facilities = current_user.condo.facilities
    end

    def facility_params
      params.require(:facility).permit(:name, :booking_price, :deposit_price, :note, :image_path, :facility_category_id)
    end

    def set_hightlight
      session[:menustatus] = 'facilities'
    end
end

