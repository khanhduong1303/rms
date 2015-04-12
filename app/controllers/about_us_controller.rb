class AboutUsController < ApplicationController
  before_action :set_about_u, only: [:show, :edit, :update, :destroy]
  include ActionController::MimeResponds
  # GET /about_us
  # GET /about_us.json
  def index
    @about_us = AboutUs.all.order('id DESC')
    @about_u = AboutUs.new
  end

  # GET /about_us/1
  # GET /about_us/1.json
  def show
  end

  # GET /about_us/new
  def new
    @about_u = AboutUs.new
  end

  # GET /about_us/1/edit
  def edit
  end

  # POST /about_us
  # POST /about_us.json
  def create
    @about_u = AboutUs.new(about_u_params)
    if @about_u.save
      @result = 1
      @message = t('common.successfully_created')
    else
      @result = 0
      @message = t('common.unsuccess')
    end
    @about_us = AboutUs.all.order('id DESC')
    @about_u = AboutUs.new
  end

  # PATCH/PUT /about_us/1
  # PATCH/PUT /about_us/1.json
  def update
      if @about_u.update(information: params[:about_us][:information])
        return render json: @about_us
      end
  end

  # DELETE /about_us/1
  # DELETE /about_us/1.json
  def destroy
    if @about_u.destroy
      @result = 1
      @message = t('common.successfully_destroyed')
    else
      @result=0
      @message= t('common.unsuccess')
    end
    @about_us = AboutUs.all.order('id DESC')
    @about_u = AboutUs.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_about_u
      @about_u = AboutUs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def about_u_params
      params.require(:about_u).permit(:information)
    end
end
