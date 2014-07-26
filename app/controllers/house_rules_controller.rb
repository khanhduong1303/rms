class HouseRulesController < ApplicationController
  before_action :set_house_rule, only: [:show, :edit, :update, :confirm, :destroy]
  before_action :set_house_rules, only: [:index, :create, :update, :destroy]
  before_action :set_highlight
  respond_to :html, :js, :json

  def index
  end

  def show
  end

  def new
    @house_rule = HouseRule.new
  end

  def create
    @house_rule = HouseRule.create(house_rule_params)
    @persisted = false
  end

  def edit
  end

  def update
    @house_rule.update_attributes(house_rule_params)
    @persisted = true
  end

  def confirm
  end

  def destroy
    @house_rule.destroy
  end

  private
  def set_house_rule
    @house_rule = HouseRule.find(params[:id])
  end

  def set_house_rules
    @house_rules = HouseRule.where(condo_id: current_user.condo_id)
  end

  def house_rule_params
    params.require(:house_rule).permit(:title, :content, :condo_id)
  end

  def set_highlight
    session[:menustatus] = 'house_rules'
  end
end

