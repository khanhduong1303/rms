class Api::HouseRulesController < Api::ApiController
  skip_before_action :authenticate_user_from_token!
  def index
    begin
      @house_rules = HouseRule.select(:id, :title, :content).where(condo_id: params[:condo_id])
    rescue Exception => e
      @house_rules = nil
    end
    unless @house_rules.nil?
      render json: {status: 'success', message: 'Found house rules', total: @house_rules.length, data: @house_rules}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found house rules', data: {}}, status: :not_found
    end
  end
end

