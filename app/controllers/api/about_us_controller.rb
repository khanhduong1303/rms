class Api::AboutUsController < ApplicationController
  include ActionController::MimeResponds
  skip_before_action :authenticate_user!
  def about_us
    if AboutUs.all.size > 0
      @about_us = AboutUs.last
      render json: PublicFunction.data_json('success', 'About us', 1, @about_us)
    else
      render json: PublicFunction.data_json('success', 'About us is null', 0, nil)
    end
  end

end
