class Api::EventsController < ApplicationController
  include ActionController::MimeResponds
  #before_action :authenticate_user!, :except => [:index, :show, :event_photo, :join_event]
  # http_basic_authenticate_with name: "admin", password: "rms.innoria"
  skip_before_filter :authenticate_user!

  # $public_function = PublicFunction.new()
  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    if page < 1 or limit < 1
      @events = Event.limit(10)
      return render json: data_json('success', 'Event list', @events.size, @events)
    end

    if limit > 0 and page > 0
      @events = Event.limit(limit).offset(page*limit-limit)
      if @events.size > 0
        return render json: data_json('success', 'Event list', @events.size, @events)
      else
        @events = Event.limit(10)
        return render json: data_json('success', 'Event list', @events.size, @events)
      end
    end
  end

  def show
    event_id = params[:event_id]
    if Event.where(:id => event_id).size > 0
      render json: data_json('success', 'Show events', 1, Event.find(event_id))
    else
      render json: data_json('failed', 'Event not found', 0, nil)
    end
  end

  def event_photo
    event_id = params[:event_id]
    if Event.where(:id => event_id).size > 0
      render json: data_json('success', 'List events images', Event.find(event_id).event_images.size, Event.find(event_id).event_images)
      # render json: {:status=>"Success", :message=>'List events images', :data=>Event.find(event_id).event_images}
    else
      # render json: {:status=>"Fail", :message=>'Event not found', :data=>nil}
      render json: data_json('failed', 'Event not found', 0, nil)
    end
  end

  def join_event
    if !params[:user_id].nil? and !params[:event_id].nil?
      if Event.where(:id => params[:event_id]).size < 1
        return render json: data_json('failed', 'Event not found', 0, nil)
      end
      if User.where(:id => params[:user_id]).size < 1
        return render json: data_json('failed', 'User not found', 0, nil)
      end
      @join_event = JoinEvent.create(:user_id => params[:user_id], :event_id => params[:event_id])
      return render json: data_json('success', 'Joined', 1, @join_event)
      # render json: {:status=>"Success", :message=>'Joined', :data=>@join_event}
    else
      render json: data_json('failed', 'Missing parameter', 0, nil)
      # render json: {:status=>"Fail", :message=>'Join fail', :data=>nil}
    end
  end

  private
  def data_json status, message, total, results=nil
    return {:status => status, :message => message, :total => total, :results => results}
  end
end
