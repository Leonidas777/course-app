class Users::ReceivedHomeworksController < Users::BaseController

  def index
    @homeworks = current_user.received_homeworks.all
  end
end
