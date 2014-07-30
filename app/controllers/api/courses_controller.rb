class Api::CoursesController < Api::ApiController
  skip_before_action :authenticate_user_from_token!

  def index

  end

  def show

  end
end

