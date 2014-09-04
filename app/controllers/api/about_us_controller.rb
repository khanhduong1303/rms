class Api::AboutUsController < Api::ApiController

  def about_us
    if AboutUs.all.size > 0
      @about_us = AboutUs.last
      unless @about_us.nil?
        render json: {status: 'success', message: 'About Us found', results: @about_us}
      end
    else
      render json: {status: 'success', message: 'About Us is empty!', results: {}}
    end
  end

end

