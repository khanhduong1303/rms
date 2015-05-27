class Api::GuardHousesController < Api::ApiController
  def guard_houses
    if params[:condo_id].nil?
      return render json: PublicFunction.data_json('failed', 'condo_id not found', 0, nil)
    end
    begin
      guard_house = GuardHouse.includes(:guard_house_images).where(condo_id:params[:condo_id])
      temp = {}
      if guard_house.size > 0
        _gh = GuardHouse.find_by_condo_id(params[:condo_id])
        temp[:photo_path] = _gh.photo_path(:thumbnail)
        temp[:map_path] = _gh.map_path(:thumbnail)
        temp[:phone] = _gh.phone
        guard = []
        _gh.guard_house_images.each do |g|
          _guard_temp = {}
          _guard_temp[:name] = g.name
          _guard_temp[:image_path] = g.image_path(:thumbnail)
          guard << _guard_temp
        end
        temp[:guards] = guard
      end
        return render json: PublicFunction.data_json('success', 'Facility list', 1, temp)
    rescue
      return render json: PublicFunction.data_json('failed', 'Load guard houses error!', 0, nil)
    end
  end
end

