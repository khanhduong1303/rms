class Api::BookingsController < ApplicationController
  include ActionController::MimeResponds
  http_basic_authenticate_with name: "admin", password: "rms.innoria"
  skip_before_filter :authenticate_user!

  def index
    @booking_facilities = Facility.where(:active => true)
    if @booking_facilities.size > 0
      render json: data_json('success', 'Booking list', @booking_facilities.size, @booking_facilities)
    else
      render json: data_json('success', 'Booking list', 0, nil)
    end
  end

  def make_a_booking
    
  end

  def check_booking
    user = params[:user_id]
    if user.nil?
      render json: data_json('failed', 'Missing parameter',0,nil)
    else
      if User.where(id:user).size > 0
        @booking = User.find(user).bookings
        @check_booking = []
        i=0
        @booking.each do |b|
          @check_booking[i]= b.time_slot.facility
          #@check_booking[i][:ok] = 'ok'
          i+=1
        end
        render json: data_json('success', 'Check booking list',@check_booking.size,@check_booking)
      else
        render json: data_json('failed', 'User_id not found',0,nil)
      end
    end


  end

  private
  def data_json status, message, total, results=nil
    return {:status=>status, :message=>message,:total=>total, :results=>results}
  end
end
