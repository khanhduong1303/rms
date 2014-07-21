class Api::HouseRulesController < Api::ApiController
  def index
    @house_rules = HouseRule.all
    unless @house_rules.present?
        @house_rules = nil
    end
    unless @house_rules.nil?
      render json: { status: 'success', message: 'Found bulletins', data: @house_rules }
    else
      render json: { status: 'success', message: 'Not found bulletins', data: {} }
    end
  end
end

