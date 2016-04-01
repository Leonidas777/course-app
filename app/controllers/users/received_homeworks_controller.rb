class Users::ReceivedHomeworksController < Users::BaseController
  def show
  end

  def index
    @homeworks = current_user.received_homeworks.recent.includes(:lesson, user: :profile).decorate
  end

  def homework
    @homework ||= Homework.find(params[:id])
  end
  helper_method :homework
end
