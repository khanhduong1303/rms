class Api::TechSupportsController < Api::ApiController
  def tech_support
    @tech_support = TechSupport.first
    unless @tech_support.nil?
      render json: {status: 'success', message: 'Tech Support found', results: @tech_support}
    else
      render json: {status: 'failed', message: 'Tech Support not found', results: {}}
    end
  end
end

