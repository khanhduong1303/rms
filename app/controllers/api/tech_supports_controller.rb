class Api::TechSupportsController < Api::ApiController
  skip_before_action :authenticate_user_from_token!

  def tech_support
    @tech_support = TechSupport.first
    unless @tech_support.nil?
      render json: {status: 'success', message: 'Tech Support found', results: @tech_support}
    else
      render json: {status: 'failed', message: 'Tech Support not found', results: {}}
    end
  end
end

