class HomesController < ApplicationController
  included ActionController::MimeResponds
  before_action :authenticate_user!, :only => [:index]
  before_action :set_hightlight
  authorize_resource :class => false 
    layout "blank" , only: :unauthor
  def index
    unless current_user.active
      redirect_to active_path
    end
      
  end
  def unauthor


  end  

  def setLanguage
    session[:language]=params[:val]
    render json: {val:params[:val]}
  end
  private
  def set_hightlight
    session[:menustatus] = 'home';
  end
end

