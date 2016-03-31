class Users::SubscribedCoursesController < Users::BaseController
  def index
    @courses = current_user.participated_courses.includes(:user, user: :profile)
  end
end
