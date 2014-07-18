class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]
  before_action :set_bookings, only: [:index]
  before_action :set_hightlight

  def index
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
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

