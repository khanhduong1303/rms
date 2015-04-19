class HomesController < ApplicationController
  included ActionController::MimeResponds
  before_action :authenticate_user!, :only => [:index]
  before_action :set_hightlight
  # authorize_resource :class => false
    layout "blank" , only: :unauthor
  def index
    unless current_user.active
      redirect_to active_path
    end
    @bulletins = Bulletin.where('condo_id' => current_user.condo_id).order(:created_at => :desc).take 3
    @events = Event.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").order(created_at: :desc).take 3
    @privileges = Privilege.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").order(created_at: :desc).take 3
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

