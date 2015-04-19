class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]
  #before_action :set_bookings, only: [:index]
  before_action :set_hightlight
  # before_action :get_column_dataType

  included ActionController::MimeResponds
  authorize_resource

  def index
    # module filter
    if params[:get_column_dataType].to_i == 1
      show_array = []
    column_names = Booking.column_names
    column_dataType = []
      unless column_names.nil?
        column_names.each { |col|
          temp = {}
          temp[:key] = col
          temp[:type] = Booking.columns_hash[col].type.to_s
          temp[:name] = t("bookings.moduleFilter.#{col}")
          column_dataType << temp
        }
      end
      return render json: column_dataType
    end
    # end module filter

    @category_id = params[:category]
    if current_user.roles.where('role_name = "Admin"').size > 0
      @categories = FacilityCategory.where(condo_id: current_user.condo_id)
    else
      @categories = FacilityCategory.where(condo_id: current_user.condo_id)
    end
    arrTimeslotId = []
    unless @category_id.nil?
      FacilityCategory.find(@category_id).facilities.each do |f|
        arrTimeslotId =  arrTimeslotId + f.time_slots.select(:id).map(&:id)
      end
    end
    if arrTimeslotId.size < 1
      arrTimeslotId << -1
    end
    if current_user.roles.where('role_name = "Admin"').size > 0
      if @category_id.nil?
        @bookings = Booking.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})")
      else
        @bookings = Booking.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").where("time_slot_id in (#{arrTimeslotId.join(',')})")
      end
    else
      if @category_id.nil?
        arrTimeslotId = []
        current_user.facilities.each do |f|
        arrTimeslotId =  arrTimeslotId + f.time_slots.select(:id).map(&:id)
      end
        @bookings = Booking.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").where("time_slot_id in (#{arrTimeslotId.join(',')})")
      else
        arrTimeslotId = []
        current_user.facilities.each do |f|
          if f.facility_category.id == @category_id.to_i
            arrTimeslotId =  arrTimeslotId + f.time_slots.select(:id).map(&:id)
          end
        end
        if arrTimeslotId.size < 1
          arrTimeslotId << -1
        end
        @bookings = Booking.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").where("time_slot_id in (#{arrTimeslotId.join(',')})")
      end
    end
    # if @users.size > 0
    #   @bookings = []
    #   @temp = []
    #   @users.each do |u|
    #     if !u.bookings.blank?
    #       u.bookings.each do |book|
    #         if !book.time_slot.nil?
    #           if current_user.roles.where('role_name = "Admin"').size >0
    #             @bookings << book
    #           else
    #             if book.time_slot.facility.user_id==current_user.id.to_i
    #               @bookings << book
    #             end
    #           end
    #
    #         end
    #       end
    #     end
    #   end
    # end
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
    if session[:language]=='en'
      render json: {val: 'dataTables.english.lang'}
    else
      render json: {val: 'dataTables.vietnamese.lang'}
    end
  end

  def filter
    category_id = params[:id]
    session[:category_id_temp]=category_id;
    if current_user.roles.where('role_name = "Admin"').size >0
      @categories = FacilityCategory.where(condo_id: current_user.condo_id)
    else
      @categories = FacilityCategory.where(user_id: current_user.id)
    end
    if category_id=='all'
      @users = User.where(condo_id: current_user.condo_id)
      if @users.size > 0
        @bookings = []
        @users.each do |u|
          if !u.bookings.blank?
            u.bookings.each do |book|
              if !book.time_slot.nil?
                if current_user.roles.where('role_name = "Admin"').size >0
                  @bookings << book
                else
                  if book.time_slot.facility.user_id==current_user.id.to_i
                    @bookings << book
                  end
                end

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
              if !book.time_slot.nil?
                if current_user.roles.where('role_name = "Admin"').size >0
                  if book.time_slot.facility.facility_category_id==category_id.to_i
                    @bookings << book
                  end
                else
                  if book.time_slot.facility.facility_category_id==category_id.to_i && book.time_slot.facility.user_id==current_user.id.to_i
                    @bookings << book
                  end
                end
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

