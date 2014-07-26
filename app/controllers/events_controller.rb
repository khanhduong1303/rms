class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_hightlight
  # GET /events
  # GET /events.json
  def index
    @events = Event.where(:user_id => current_user.id)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event_image = @event.event_images
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    @condo = Condo.all
    @event_image = EventImage.new
  end

  # GET /events/1/edit
  def edit
    @condo = Condo.all
    @event_image = @event.event_images
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @events = Event.all
    respond_to do |format|
      if @event.save
        if params[:event][:image]
          params[:event][:image].each do |image|
            @event.event_images.create(:image => image)
          end
        end
        format.html { redirect_to events_path, notice: 'Event was successfully created.' #redirect_to @event
        }
        format.json {#render :show, status: :created, location: @event
        }
        format.js
      else
        format.html {
        }
        format.json {# render json: @event.errors, status: :unprocessable_entity
        }
        format.js
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @events = Event.all
    respond_to do |format|
      if @event.update(event_params)
        if params[:image_id]
          params[:image_id].each do |image_id|
            @event_image= EventImage.find(image_id).destroy
          end
        end
        if params[:event][:image]
          params[:event][:image].each do |image|
            @event.event_images.create(:image => image)
          end
        end
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' #redirect_to @event
        }
        format.json { render :show, status: :ok, location: @event }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :date, :event_start, :event_end, :location, :organiser, :description, :user_id)
  end

  def set_hightlight
    session[:menustatus]='events'
  end
end

