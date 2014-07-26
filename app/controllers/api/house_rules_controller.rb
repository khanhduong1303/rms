class Api::HouseRulesController < Api::ApiController
  def index
    begin
      @house_rules = HouseRule.where(condo_id: params[:condo_id])
    rescue Exception => e
      @house_rules = nil
    end
    unless @house_rules.nil?
      render json: {status: 'success', message: 'Found house rules', total: @house_rules.size, data: @house_rules}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found house rules', data: {}}, status: :not_found
    end
  end
end

