class FacilitiesController < ApplicationController
before_action :set_hightlight
 respond_to :html, :js, :json
def index
	@facilities = current_user.condo.facilities
end


  def confirm
    @facility = Facility.find(params[:facility_id])
  end




def set_hightlight
    session[:menustatus] = 'facilities'
end
end

