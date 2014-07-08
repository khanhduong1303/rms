class BulletinsController < ApplicationController
  before_action :set_bulletin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :set_hightlight
  respond_to :html, :js, :json

  def index
    @bulletins = Bulletin.all
  end

  def show
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)

    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to action: 'index', notice: 'Bulletin was successfully created.' }
        format.json { render :show, status: :created, location: @bulletin }
      else
        format.html { render :new }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bulletin.update(bulletin_params)
        format.html { redirect_to @bulletin, notice: 'Bulletin was successfully updated.' }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :date, :content, :send_notify, :condo_id)
    end

    def set_hightlight
      session[:menustatus] = 'bulletins'
    end
end
