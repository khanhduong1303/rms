class HomesController < ApplicationController
  before_action :authenticate_user!, :only => [:index]
  before_action :set_hightlight

  def index
  end

  private
  def set_hightlight
    session[:menustatus] = 'home';
  end
end

