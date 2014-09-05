class TechSupportsController < ApplicationController
  before_action :set_tech_support, only: [:show, :edit, :update, :destroy]
  include ActionController::MimeResponds
  # GET /tech_supports
  # GET /tech_supports.json
  def index
    @tech_supports = TechSupport.all.order('id DESC')
    @tech_support = TechSupport.new
  end

  # GET /tech_supports/1
  # GET /tech_supports/1.json
  def show
  end

  # GET /tech_supports/new
  def new
    @tech_support = TechSupport.new
  end

  # GET /tech_supports/1/edit
  def edit
  end

  # POST /tech_supports
  # POST /tech_supports.json
  def create
    @tech_support = TechSupport.new(tech_support_params)
    if @tech_support.save
      @result=1
      @message='Tech support was successfully created!'
    else
      @result=0
      @message= 'Unsuccess!'
    end
    @tech_supports = TechSupport.all.order('id DESC')
    @tech_support = TechSupport.new
  end

  # PATCH/PUT /tech_supports/1
  # PATCH/PUT /tech_supports/1.json
  def update
    respond_to do |format|
      if @tech_support.update(tech_support_params)
        format.html { redirect_to @tech_support, notice: 'Tech support was successfully updated.' }
        format.json { render :show, status: :ok, location: @tech_support }
      else
        format.html { render :edit }
        format.json { render json: @tech_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tech_supports/1
  # DELETE /tech_supports/1.json
  def destroy
    if @tech_support.destroy
      @result=1
      @message='Tech support was successfully destroyed!'
    else
      @result=0
      @message= 'Unsuccess!'
    end
    @tech_supports = TechSupport.all.order('id DESC')
    @tech_support = TechSupport.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech_support
      @tech_support = TechSupport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tech_support_params
      params.require(:tech_support).permit(:name, :address, :phone, :email)
    end
end
