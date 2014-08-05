class Api::TechSupportsController < ApplicationController
  include ActionController::MimeResponds
  # http_basic_authenticate_with name: "admin", password: "rms.innoria"
  skip_before_filter :authenticate_user!

  def tech_support
    if TechSupport.all.size > 0
      @tech_support = TechSupport.all
      render json: PublicFunction.data_json('success', 'All Tech support', 1, @tech_support)
    else
      render json: PublicFunction.data_json('success', 'Tech support is null', 0, nil)
    end
  end

end
