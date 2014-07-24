class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]
  before_action :set_bookings, only: [:index]
  before_action :set_hightlight

  def index
  end

  def deleteColection
    params[:book_id].each do |book|
      @book = Booking.find(book)
      @book.destroy
    end
      return render json: {status:'success'}
  end

  def updateStatus
    if Booking.where(id:params[:book_id]).size < 1 && !params[:book_stt].nil?
      return render json: {status:'failed'}
    end
    @book = Booking.find(params[:book_id])
    if @book.update_attributes(:status=> params[:book_stt])
      return render json: {status:'success'}
    else
      return render json: {status:'failed'}
    end
  end

  def confirm
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_bookings
      @bookings = Booking.all
    end

    def booking_params
      params[:booking]
    end

    def set_hightlight
      session[:menustatus] = 'bookings'
    end
end

