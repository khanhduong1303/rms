class HomesController < ApplicationController
  before_action :authenticate_user!, :only => [:index]
  before_action :set_hightlight
  authorize_resource :class => false 
  def index
  end

  private
  def set_hightlight
    session[:menustatus] = 'home';
  end
end

