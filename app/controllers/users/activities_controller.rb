class Users::ActivitiesController < Users::BaseController
  def index
    @activities = current_user.activities_for_me.recent.includes(trackable: :lesson, owner: :profile).decorate
  end
end
