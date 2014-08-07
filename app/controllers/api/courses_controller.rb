class Api::CoursesController < Api::ApiController
  before_action :set_course, only: [:show]
  before_action :set_courses, only: [:index]
  skip_before_action :authenticate_user_from_token!

  def index
    unless @courses.nil?
      render json: {status: 'success', message: 'Found courses', total: @courses.count, data: @courses}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found courses', data: {}}, status: :not_found
    end
  end

  def show
    unless @course.nil?
      render json: {status: 'success', message: 'Found course', data: @course}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found course', data: {}}, status: :not_found
    end
  end

  private
    def set_course
      begin
        @course = Course.select(:id, :name, :image_path_file_name, :description, :phone, :email, :more_info).find(params[:course_id])
      rescue ActiveRecord::RecordNotFound => e
        @course = nil
      end
    end

    def set_courses
      begin
        @limit = params[:limit]
        @page = params[:page]
        @limit = @limit.nil? ? 5 : @limit.to_i
        @page = @page.nil? ? 1 : @page.to_i
        @courses = Course.select(:name, :instructor, :price).where(condo_id: params[:condo_id]).limit(@limit).offset((@page - 1) * @limit)
      rescue Exception => e
        @courses = nil
      end
    end
end

