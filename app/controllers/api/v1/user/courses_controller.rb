class Api::V1::User::CoursesController < Api::V1::User::BaseController
  def index
    courses = current_user.courses
    respond_with_success courses
  end
end
