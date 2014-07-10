class EventImagesController < ApplicationController
  before_action :set_event_image, only: [:show, :edit, :update, :destroy]

  # GET /event_images
  # GET /event_images.json
  def index
    @event_images = EventImage.all
  end

  # GET /event_images/1
  # GET /event_images/1.json
  def show
  end

  # GET /event_images/new
  def new
    @event_image = EventImage.new
  end

  # GET /event_images/1/edit
  def edit
  end

  # POST /event_images
  # POST /event_images.json
  def create
    @event_image = EventImage.new(event_image_params)

    respond_to do |format|
      if @event_image.save
        format.html { redirect_to @event_image, notice: 'Event image was successfully created.' }
        format.json { render :show, status: :created, location: @event_image }
      else
        format.html { render :new }
        format.json { render json: @event_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_images/1
  # PATCH/PUT /event_images/1.json
  def update
    respond_to do |format|
      if @event_image.update(event_image_params)
        format.html { redirect_to @event_image, notice: 'Event image was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_image }
      else
        format.html { render :edit }
        format.json { render json: @event_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_images/1
  # DELETE /event_images/1.json
  def destroy
    @event_image.destroy
    respond_to do |format|
      format.html { redirect_to event_images_url, notice: 'Event image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_image
      @event_image = EventImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_image_params
      params.require(:event_image).permit(:description, :image)
    end
end
