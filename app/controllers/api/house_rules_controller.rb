class Api::HouseRulesController < Api::ApiController
  def index
    begin
      @rule_categories = HouseruleCategory.where(condo_id: params[:condo_id])
    rescue Exception => e
      @rule_categories = nil
    end
    unless @rule_categories.nil?
      @rules = []
      @rule_categories.each do |rule_category|
        temp = []
        rule_category.house_rules.each do |rule|
          temp << {title: rule.title, content: rule.content }
        end
        @rules << {houserule_category_name: rule_category.name, total: rule_category.house_rules.size, house_rules: temp}
      end
      render json: {status: 'success', message: 'Found forms', total: @rule_categories.length, results: @rules}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found house rules', results: {}}, status: :not_found
    end
  end
end

