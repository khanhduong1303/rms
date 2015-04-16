class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :change_active, :confirm, :destroy]
  before_action :set_facilities, only: [:index, :create, :update, :destroy]
  before_action :set_admin_facilities, only: [:index, :create, :update, :destroy]
  before_action :set_hightlight
  respond_to :json, :html, :js
  #authorize_resource
  def index
    @category = FacilityCategory.where(:condo_id => current_user.condo_id)
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
    @timeslots = @facility.time_slots
    @timeslot = TimeSlot.new

  end

  def add_timeslot
    @timeslot = TimeSlot.create(timeslot_params)
    @facility = Facility.find(params[:time_slot][:facility_id])
    @timeslots = @facility.time_slots

  end

  def delete_timeslot
    unless TimeSlot.find(params[:id]).nil?
      TimeSlot.find(params[:id]).destroy!
      return render json: {'result' => true}
    end
    return render json: {'result' => false}
  end

  def update
    @facility.update_attributes(facility_params)
    @persisted = true
  end

  def change_active
    begin
      @facility.active = params[:active]
      @facility.save
      render json: {status: 'success'}
    rescue Exception => e
      render json: {status: 'failed'}
    end
  end

  def confirm
  
  end

  def change_peak
    @timeslot = TimeSlot.find(params[:id])
    @timeslot.peak = params[:peak]
    @timeslot.save
    render json: {peak: @timeslot.peak}
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
    @category_id = params[:category]
    if @category_id.nil?
      @facilities = current_user.facilities.order(created_at: :desc)
    else
      @facilities = current_user.facilities.where(:facility_category_id => @category_id).order(created_at: :desc)
    end
  end
  def set_admin_facilities
     if current_user.roles.where('role_name = "Admin"').size >0
       @category_id = params[:category]
       if @category_id.nil?
         @facilities = current_user.condo.facilities.order(created_at: :desc)
       else
         @facilities = current_user.condo.facilities.where(:facility_category_id => @category_id).order(created_at: :desc)
       end
     end
  end

  def facility_params
    params.require(:facility).permit(:name, :booking_price, :deposit_price, :note, :image_path, :facility_category_id , :user_id)
  end

  def set_hightlight
    session[:menustatus] = 'facilities'
  end
end

