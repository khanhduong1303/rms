class Api::BookingsController < Api::ApiController
  def index
    begin
      @users = Condo.find(User.find(params[:user_id]).condo_id).users
      arr_group_id  = []
      @users.each do |user|
        arr_group_id << user.id
      end
    rescue
      return render json: PublicFunction.data_json('failed', 'user_id not found', 0, nil)
    end
    begin
      @booking_facilities = []
      FacilityCategory.all.each do |cate|
        temp = {}
        temp[:category_id] = cate.id
        temp[:category] = cate.name
        fc_temp = Facility.where("active=true and user_id in (#{arr_group_id.join(',')}) and facility_category_id=#{cate.id}")
        temp[:facilities] = process_results fc_temp
        @booking_facilities << temp
      end
      # @booking_facilities = Facility.where("active=true and user_id in (#{arr_group_id.join(',')})")
      if @booking_facilities.size > 0
        return render json: PublicFunction.data_json('success', 'Facility list', @booking_facilities.size, @booking_facilities)
      else
        return render json: PublicFunction.data_json('failed', 'Facility list', 0, nil)
      end
    rescue
      return render json: PublicFunction.data_json('failed', 'Load facility error', 0, nil)
    end

  end

  def make_a_booking
    if !params[:user_id].nil? && !params[:preferred_date].nil? && !params[:time_slot_id].nil?
      if Booking.where(date_book:params[:preferred_date].to_date, time_slot_id:params[:time_slot_id]).size > 0
        return render json: PublicFunction.data_json('failed', 'Booking existed!', 0, nil)
      end
      @booking = Booking.create(time_slot_id:params[:time_slot_id], date_submit:Time.now , date_expiry:1.days.from_now , date_book:params[:preferred_date], user_id:params[:user_id], status:'Reserved')
      if @booking
        return render json: PublicFunction.data_json('success', 'Booking success', 1, @booking)
      else
        return render json: PublicFunction.data_json('failed', 'Booking list', 0, nil)
      end
    else
      return render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
    end
  end

  def check_booking
    user = params[:user_id]
    if user.nil?
      return render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
    else
      if User.where(id: user).size > 0
        @booking = User.find(user).bookings
        @facilities = []
        i=0
        @booking.each do |book|
          temp = Hash.new
          if !book.time_slot.nil?
          temp[:name]= book.time_slot.facility.name
          temp[:booking_price]= book.time_slot.facility.booking_price
          temp[:deposit_price]= book.time_slot.facility.deposit_price
          temp[:note]= book.time_slot.facility.note
          temp[:image_path]= book.time_slot.facility.image_path.url
          temp[:status]=book.status
          temp[:book_id] = book.id
          end
          @facilities[i] = temp
          #temp[b.status] = b.status
          #facilities[i][:ok] = 'ok'
          i+=1
        end
        # facilities[0].status = 'booked'
        return render json: PublicFunction.data_json('success', 'Check booking list', @facilities.size, @facilities)
      else
        return render json: PublicFunction.data_json('failed', 'User_id not found', 0, nil)
      end
    end
  end

  def booking_detail
    if params[:booking_facility_id].nil?
      return render json: PublicFunction.data_json('failed', 'Missing parameter \'booking_facility_id\'', 0, nil)
    end
    begin
      temp = {}
      temp[:facility] = Facility.find(params[:booking_facility_id])
      temp[:time_slots] = Facility.find(params[:booking_facility_id]).time_slots.nil? ? nil : Facility.find(params[:booking_facility_id]).time_slots
      return render json: PublicFunction.data_json('success', 'Show booking facility detail!', 1, temp)
    rescue
      return render json: PublicFunction.data_json('failed', 'Error!', 0, nil)
    end
  end

  def delete_my_booking
    if params[:booking_id].nil? || params[:booking_id].blank?
      return render json: PublicFunction.data_json('failed', 'Missing parameter \'booking_id\'', 0, nil)
    end
    begin
      if Booking.where(id:params[:booking_id]).size > 0
        Booking.destroy(Booking.find(params[:booking_id]))
        return render json: PublicFunction.data_json('success', 'Delete booking was success!', 1, {})
      else
        return render json: PublicFunction.data_json('failed', 'booking_id not found!', 0, nil)
      end
    rescue
      return render json: PublicFunction.data_json('failed', 'Error delete booking!', 0, nil)
    end
  end

  private
  def process_results results=nil
      booking_data=[]
      i=0
      results.each do |booking|
        temp = Hash.new
        temp[:id]= booking.id
        temp[:user_id]= booking.user_id
        temp[:name]= booking.name
        temp[:booking_price]= booking.booking_price
        temp[:deposit_price]=booking.deposit_price
        temp[:note]=booking.note
        temp[:active]=booking.active
        temp[:created_at]=booking.created_at
        temp[:updated_at]=booking.updated_at
        temp[:facility_category_id]=booking.facility_category_id
        temp[:image_path]=booking.image_path.url
        booking_data[i] = temp
        i+=1
      end
      return booking_data
  end
  
end

