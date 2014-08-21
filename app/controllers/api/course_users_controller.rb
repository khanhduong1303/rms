class Api::CourseUsersController < Api::ApiController
  before_action :set_course_user, only: [:show, :destroy]
  skip_before_action :authenticate_user_from_token!

  def create
    begin
      @course_user = CourseUser.create(course_user_params)
      render json: { status: 'success', message: 'Create join success', results: {} }, status: :ok
    rescue ArgumentError => e
      # Do nothing
    end
  end

  def show
    if @course_user.present?
      render json: { status: 'success', message: 'Has join', results: {} }, status: :ok
    else
      render json: { status: 'success', message: 'Has not join', results: {} }, status: :ok
    end
  end

  def destroy
    begin
      @course_user.destroy
      render json: { status: 'success', message: 'Delete join success', results: {} }, status: :ok
    rescue NoMethodError => e
      render json: { status: 'failed', message: 'Not found join', results: {} }, status: :not_found
    end
  end

  private
    def course_user_params
      begin
        params.permit(:course_id, :user_id)
      rescue ActionController::ParameterMissing => e
        render json: { status: 'failed', message: e.message, results: {} }
      end
    end

    def set_course_user
      @course_user = CourseUser.find_by_course_id_and_user_id(params[:course_id], params[:user_id])
    end
end

