class BulletinsController < ApplicationController
  before_action :set_bulletin, only: [:show, :edit, :update, :destroy]
  before_action :set_bulletins, only: [:index, :create, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :set_hightlight
  respond_to :html, :js, :json

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
  end

  def update
    @bulletin.update_attributes(bulletin_params)
  end

  def confirm
    @bulletin = Bulletin.find(params[:bulletin_id])
  end

  def destroy
    @bulletin.destroy
    flash[:notice] = 'Bulletin was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def set_bulletins
      @bulletins = Bulletin.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :date, :content, :send_notify, :condo_id)
    end

    def set_hightlight
      session[:menustatus] = 'bulletins'
    end
end
