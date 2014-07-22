class FacilityStatusesController < ApplicationController
  def new
    @facility_status = FacilityStatus.new
  end

  def create
    @facility_status = FacilityStatus.create(facility_status_params)
  end

  def cancel
  end

  private
    def facility_status_params
      params.require(:facility_status).permit(:image_path, :close_from, :close_to, :reason, :facility_id)
    end
end

