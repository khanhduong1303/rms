class Api::EventsController < Api::ApiController
  def index
    if params[:condo_id]
      event = Condo.find(params[:condo_id]).events
      limit = params[:limit].to_i
      page = params[:page].to_i
      if limit > 0 and page > 0
        @events = event.limit(limit).offset(page*limit-limit).where(:archived => f)
        if @events.size > 0
          @full_event = []
          @events.each do |event|
            temp = Hash.new

            temp[:id]= event.id
            temp[:time_start] = event.event_start
            temp[:time_end] = event.event_end
            temp[:name]= event.name
            temp[:date] = event.date
            if  event.event_images.size > 0
              temp[:image]= event.event_images.first.image.url(:thumb)
            else
              temp[:image] = "/images/no-image.jpg"
            end

            temp[:organiser] = event.organiser

            @full_event << temp
          end
          return render json: data_json('success', 'Event list', event.size, @full_event)
        else
          return render json: data_json('success', 'Not found Event')
        end

      else
        return render json: data_json('fails', 'limit and page is not true')
      end
    else
      return render json: data_json('failed', 'Missing condo_id')
    end
  end


  def event_archives
    if params[:condo_id]
      event = Condo.find(params[:condo_id]).events
      limit = params[:limit].to_i
      page = params[:page].to_i
      if limit > 0 and page > 0
        @events = event.limit(limit).offset(page*limit-limit).where(archived:1)
        if @events.size > 0
          @full_event = []
          @events.each do |event|
            temp = Hash.new

            temp[:id]= event.id
            temp[:time_start] = event.event_start
            temp[:time_end] = event.event_end
            temp[:name]= event.name
            temp[:date] = event.date
            if  event.event_images.size > 0
              temp[:image]= event.event_images.first.image.url(:thumb)
            else
              temp[:image] = "/images/no-image.jpg"
            end

            temp[:organiser] = event.organiser

            @full_event << temp
          end
          return render json: data_json('success', 'Event archived list', event.size, @full_event)
        else
          return render json: data_json('success', 'Not found Event')
        end

      else
        @events = event.limit(10).where(archived:1)
        if @events.size > 0
          @full_event = []
          @events.each do |event|
            temp = Hash.new

            temp[:id]= event.id
            temp[:time_start] = event.event_start
            temp[:time_end] = event.event_end
            temp[:name]= event.name
            temp[:date] = event.date
            if  event.event_images.size > 0
              temp[:image]= event.event_images.first.image.url(:thumb)
            else
              temp[:image] = "/images/no-image.jpg"
            end

            temp[:organiser] = event.organiser

            @full_event << temp
          end
          return render json: data_json('success', 'Event archived list', event.size, @full_event)
        else
          return render json: data_json('success', 'Empty!')
        end
      end
    else
      return render json: data_json('failed', 'Missing condo_id')
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
    if JoinEvent.where(:event_id => event_id, :user_id => user_id).size >0
      user_join = true
    else
      user_join = false
    end
    render json: {:status => "success", :message => "Number resident",
                  :results => {
                      :user_join => user_join,
                      :num_user => num_user
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
      render json: data_json('success', 'List events images', 1, all_image)
      # render json: {:status=>"Success", :message=>'List events images', :data=>Event.find(event_id).event_images}
    else
      # render json: {:status=>"Fail", :message=>'Event not found', :data=>nil}
      render json: data_json('failed', 'Event not found', 0, nil)
    end
  end

  def join_event
    if !params[:user_id].nil? and !params[:event_id].nil?
      if Event.where(:id => params[:event_id]).size < 1
        return render json: data_json('failed', 'Event not found')
      end
      if User.where(:id => params[:user_id]).size < 1
        return render json: data_json('failed', 'User not found', 0, nil)
      end
      @join_event = JoinEvent.create(:user_id => params[:user_id], :event_id => params[:event_id])
      return render json: data_json('success', 'Joined', 1, @join_event)
      # render json: {:status=>"Success", :message=>'Joined', :data=>@join_event}
    else
      render json: data_json('failed', 'Missing parameter')
      # render json: {:status=>"Fail", :message=>'Join fail', :data=>nil}
    end
  end

  private
  def data_json status, message, total =0, results={}
    return {:status => status, :message => message, :total => total, :results => results}
  end
end

