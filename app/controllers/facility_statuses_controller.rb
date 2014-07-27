class FacilityStatusesController < ApplicationController
  before_action :set_previous, only: [:previous]
  before_action :set_next, only: [:next]
  before_action :new_facility_status, :set_date_data, only: [:new, :previous, :next]
  @@date = Date.today

  def new
  end

  def previous
  end

  def next
  end

  def create
    @facility_status = FacilityStatus.create(facility_status_params)
  end

  private
    def facility_status_params
      params.require(:facility_status).permit(:image_path, :close_from, :close_to, :reason, :facility_id)
    end

    def new_facility_status
      @facility_status = FacilityStatus.new
    end

    def set_previous
      @@date <<= 1
    end

    def set_next
      @@date >>= 1
    end

    def set_date_data
      @date = Date.today
      @current = ((@date.year == @@date.year) && (@date.month == @@date.month)) ? true : false
      @date = @@date
      @month = @date.month
      @month_name = @date.strftime('%b')
      @year = @date.year
      @beginning_of_month = @date.beginning_of_month
      @end_of_month = @date.end_of_month
    end
end

