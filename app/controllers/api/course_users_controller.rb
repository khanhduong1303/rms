class Api::CourseUsersController < Api::ApiController
  skip_before_action :authenticate_user_from_token!

  def create
    @course_user = CourseUser.create(course_user_params)
  end

  private
    def course_user_params
      params.require(:course_user).permit(:course_id, :user_id)
    end
end

