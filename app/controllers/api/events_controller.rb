class Api::EventsController < ApplicationController
  include ActionController::MimeResponds
  #before_action :authenticate_user!, :except => [:index, :show, :event_photo, :join_event]
  http_basic_authenticate_with name: "admin", password: "admin"
     skip_before_filter :authenticate_user!
  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    if page < 1
      return render json: data_json('Page can not smaller one')
    end
    @events = Event.limit(limit).offset(page*limit-limit)
    # render json: {:status=>"Success", :message=>'All events', :data=>@events }
    if @events.size > 0
      render json: data_json('Event list', true, @events)
    else
      render json: data_json("Record not enough to divide {page:#{page}, limit:#{limit}}")
    end

  end

  def show
    event_id = params[:event_id]
    if Event.where(:id => event_id).size > 0
      render json: data_json('Show events', true, Event.find(event_id))
    else
      render json: data_json('Event not found')
    end
  end

  def event_photo
    event_id = params[:event_id]
    if Event.where(:id => event_id).size > 0
      render json: data_json('List events images', true, Event.find(event_id).event_images)
      # render json: {:status=>"Success", :message=>'List events images', :data=>Event.find(event_id).event_images}
    else
      # render json: {:status=>"Fail", :message=>'Event not found', :data=>nil}
      render json: data_json('Event not found')
    end
  end

  def join_event
    @join_event = JoinEvent.create(:user_id=> params[:user_id], :event_id=>params[:event_id])
    if @join_event
      render json: data_json('Joined', true, @join_event)
      # render json: {:status=>"Success", :message=>'Joined', :data=>@join_event}
    else
      render json: data_json('Join not success')
      # render json: {:status=>"Fail", :message=>'Join fail', :data=>nil}
    end
  end

  private
  def data_json message, type=false, results=nil
    if type==true
      return {:status=>"success", :message=>message, :results=>results}
    else
      return {:status=>"failed", :message=>message, :results=>results}
    end
  end
end
