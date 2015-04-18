class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  include ActionController::MimeResponds
  authorize_resource
  # GET /courses
  # GET /courses.json
  def index
    @course = Course.new
    set_courses
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

      if @course.save
        @result = 1
        @message = t('common.successfully_created')
      else
        @result = 0
        @message = t('common.unsuccess')
      end
    @course = Course.new
    set_courses
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
      if @course.update(course_params)
        @result=1
        @message=t('common.successfully_updated')
      else
        @result=0
        @message= t('common.unsuccess')
      end
      @course = Course.new
      set_courses
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    if @course.destroy
      @result=1
      @message=t('common.successfully_destroyed')
    else
      @result=0
      @message= t('common.unsuccess')
    end
    @course = Course.new
    set_courses
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:name, :description, :instructor, :price, :phone, :email, :image_path, :more_info, :condo_id)
  end

  def set_courses
    if current_user.roles.where(role_name: 'Admin').size > 0
      @courses = Course.all.order('id DESC')
    else
      @courses = Course.where(condo_id: current_user.condo_id)
    end
  end

end
