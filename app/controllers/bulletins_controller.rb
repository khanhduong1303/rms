class BulletinsController < ApplicationController
  before_action :set_bulletin, only: [:show, :edit, :update, :confirm, :destroy]
  before_action :set_bulletins, only: [:index, :create, :update, :destroy]
  before_action :set_highlight
  respond_to :html, :js, :json
  authorize_resource

  def index
  end

  def show
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
  end

  def create
    @bulletin = Bulletin.create(bulletin_params)
    @persisted = false
  end

  def update
    @bulletin.update_attributes(bulletin_params)
    @persisted = true
  end

  def confirm
  end

  def destroy
    @bulletin.destroy
  end

  private
  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def set_bulletins
    @bulletins = Bulletin.where(condo_id: current_user.condo_id).order(date: :desc)
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :date, :content, :send_notify, :condo_id , :image_path)
  end

  def set_highlight
    session[:menustatus] = 'bulletins'
  end
end

