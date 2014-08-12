class BookingsController < ApplicationController
  layout 'menu'
  before_action :set_booking, only: [:update, :destroy]
  #before_action :set_bookings, only: [:index]
  before_action :set_hightlight
  included ActionController::MimeResponds
  authorize_resource
  def index
    session[:category_id_temp]='all';
    @users = User.where(condo_id: current_user.condo_id)
    @categories = FacilityCategory.where(condo_id: current_user.condo_id)
    if @users.size > 0
      @bookings = []
      @users.each do |u|
        if !u.bookings.blank?
          u.bookings.each do |book|
            if book.time_slot.facility.user_id==current_user.id.to_i
              @bookings << book
            end
          end
        end
      end
    end
  end

  def deleteColection
    params[:book_id].each do |book|
      @book = Booking.find(book)
      @book.destroy
    end
    return render json: {status: 'success'}
  end

  def updateStatus
    if Booking.where(id: params[:book_id]).size < 1 && !params[:book_stt].nil?
      return render json: {status: 'failed'}
    end
    @book = Booking.find(params[:book_id])
    if @book.update_attributes(:status => params[:book_stt])
      return render json: {status: 'success'}
    else
      return render json: {status: 'failed'}
    end
  end

  def confirm
  end

  def getLanguage
    if session[:language].nil? || session[:language]=='en'
      render json: {val:'dataTables.english.lang'}
    else
      render json: {val:'dataTables.vietnamese.lang'}
    end
  end

  def filter
    category_id = params[:id]
    session[:category_id_temp]=category_id;
    @categories = FacilityCategory.where(condo_id: current_user.condo_id)
    if category_id=='all'
      @users = User.where(condo_id: current_user.condo_id)
      if @users.size > 0
        @bookings = []
        @users.each do |u|
          if !u.bookings.blank?
            u.bookings.each do |book|
              if book.time_slot.facility.user_id==current_user.id.to_i
                @bookings << book
              end
            end
          end
        end
      end
    else
      @bookings = []
      @users = User.where(condo_id: current_user.condo_id)
      if @users.size > 0
        @bookings = []
        @users.each do |u|
          if !u.bookings.blank?
            u.bookings.each do |book|
              if book.time_slot.facility.facility_category_id==category_id.to_i && book.time_slot.facility.user_id==current_user.id.to_i
                @bookings << book
              end
            end
          end
        end
      end
    end
    respond_to do |format|
      format.html
      format.js
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

