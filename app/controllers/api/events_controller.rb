class Api::EventsController < ApplicationController
  include ActionController::MimeResponds
  #before_action :authenticate_user!, :except => [:index, :show, :event_photo, :join_event]
     skip_before_filter :authenticate_user!
  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    @events = Event.limit(limit).offset(page*limit-limit)
    render json: {:status=>"Success", :message=>'All events', :data=>@events }
  end

  def show
    event_id = params[:id]
    if Event.where(:id => event_id).size > 0
      render json: {:status=>"Success", :message=>'Show events', :data=>Event.find(event_id)}
    else
      render json: {:status=>"Fail", :message=>'Event not found', :data=>nil}
    end
  end

  def event_photo
    event_id = params[:id]
    if Event.where(:id => event_id).size > 0
      render json: {:status=>"Success", :message=>'List events images', :data=>Event.find(event_id).event_images}
    else
      render json: {:status=>"Fail", :message=>'Event not found', :data=>nil}
    end
  end

  def join_event
    @join_event = JoinEvent.create(:user_id=> params[:user_id], :event_id=>params[:event_id])
    if @join_event
      render json: {:status=>"Success", :message=>'Joined', :data=>@join_event}
    else
      render json: {:status=>"Fail", :message=>'Join fail', :data=>nil}
    end
  end

end
