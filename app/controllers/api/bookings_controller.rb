class Api::BookingsController < ApplicationController
  include ActionController::MimeResponds
  # http_basic_authenticate_with name: "admin", password: "rms.innoria"
  skip_before_filter :authenticate_user!

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
    @booking_facilities = Facility.where("active=true and user_id in (#{arr_group_id.join(',')})")
    if @booking_facilities.size > 0
      return render json: PublicFunction.data_json('success', 'Booking list', @booking_facilities.size, @booking_facilities)
    else
      return render json: PublicFunction.data_json('failed', 'Booking list', 0, nil)
    end
  end

  def make_a_booking
    if !params[:user_id].nil? && !params[:preferred_date].nil? && !params[:time_slot_id].nil?
      @booking = Booking.create(time_slot_id:params[:time_slot_id], date_submit:params[:preferred_date], user_id:params[:user_id], status:'Waiting')
      if @booking
        return render json: PublicFunction.data_json('success', 'Booking success', 1, @booking)
      else
        render json: PublicFunction.data_json('failed', 'Booking list', 0, nil)
      end
    end
  end

  def check_booking
    user = params[:user_id]
    if user.nil?
      render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
    else
      if User.where(id: user).size > 0
        @booking = User.find(user).bookings
        @facilities = []
        i=0
        @booking.each do |book|
          temp = Hash.new
          temp[:name]= book.time_slot.facility.name
          temp[:booking_price]= book.time_slot.facility.booking_price
          temp[:deposit_price]= book.time_slot.facility.deposit_price
          temp[:note]= book.time_slot.facility.note
          temp[:status]=book.status
          @facilities[i] = temp
          #temp[b.status] = b.status
          #facilities[i][:ok] = 'ok'
          i+=1
        end
        # facilities[0].status = 'booked'
        render json: PublicFunction.data_json('success', 'Check booking list', @facilities.size, @facilities)
      else
        render json: PublicFunction.data_json('failed', 'User_id not found', 0, nil)
      end
    end


  end
end
