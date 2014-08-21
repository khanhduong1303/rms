class Api::EventsController < ApplicationController
  include ActionController::MimeResponds
  #before_action :authenticate_user!, :except => [:index, :show, :event_photo, :join_event]
  # http_basic_authenticate_with name: "admin", password: "admin"
  skip_before_filter :authenticate_user!

  def index
    if User.where(id:params[:user_id]).size < 1
      return render json: data_json('failed', 'Missing user_id', 0, nil)
    end
    event = User.find(params[:user_id]).condo.events
    limit = params[:limit].to_i
    page = params[:page].to_i
    if page < 1 or limit < 1
    @events = event.limit(10)
      return render json: data_json('success', 'Event list', event.size, @events.to_json(:include => :event_images))
    end

    if limit > 0 and page > 0
      @events = event.limit(limit).offset(page*limit-limit)
      if @events.size > 0
         @full_event = []
         @events.each do |event|
           temp = Hash.new
           temp[:id]= event.id
           temp[:name]= event.name
           temp[:date] = event.date
           temp[:image]= event.event_images.first.image.url(:thumb)
           @full_event << temp
        end
        return render json: data_json('success', 'Event list',event.size, @full_event)
      else
        @events = event.limit(10)
        return render json: data_json('success', 'Event list', event.size, @events.to_json(:include => :event_images))
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

  def list_user
    event_id = params[:event_id]
    user_id = params[:user_id]
    num_user = JoinEvent.where(:event_id => event_id).size
  if JoinEvent.where(:event_id => event_id , :user_id => user_id).size >0
     user_join = true
   else
    user_join = false 
   end 
    render json: {:status => "success", :message => "Number resident", 
                    :results => {
                          :user_join => user_join , 
                          :num_user =>  num_user
                                 }   
                  }
  end

  def event_photo
    event_id = params[:event_id]
   event_images =EventImage.where(:event_id => event_id)
    if event_images.size > 0
      all_image = []
      event_images.each do |e|
        temp = Hash.new
        temp[:image_url] = e.image.url
        temp[:image_url_thumb] = e.image.url(:thumb)
        all_image << temp
      end
      render json: data_json('success', 'List events images',1, all_image)
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
