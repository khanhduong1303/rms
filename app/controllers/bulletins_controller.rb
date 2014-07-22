class BulletinsController < ApplicationController
  before_action :set_bulletin, only: [:show, :edit, :update, :confirm, :destroy]
  before_action :set_bulletins, only: [:index, :create, :update, :destroy]
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
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def set_bulletins
      @bulletins = Bulletin.where(user_id: current_user.id).order(date: :desc)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :date, :content, :send_notify, :user_id)
    end

    def set_hightlight
      session[:menustatus] = 'bulletins'
    end
end

