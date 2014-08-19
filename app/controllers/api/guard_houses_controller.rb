class Api::GuardHousesController < ApplicationController
  include ActionController::MimeResponds
  skip_before_filter :authenticate_user!

  def guard_houses
    if params[:condo_id].nil?
      return render json: PublicFunction.data_json('failed', 'condo_id not found', 0, nil)
    end
    begin
      @guard_houses = GuardHouse.includes(:guard_house_images).where(condo_id:params[:condo_id])
      # @guard_houses.each do |tk|
      #   temp||[] << @guard_houses.guard_house_images.name
      # end
        return render json: PublicFunction.data_json('success', 'Facility list', @guard_houses.size, @guard_houses)
    rescue
      return render json: PublicFunction.data_json('failed', 'Load guard houses error!', 0, nil)
    end
  end
end
