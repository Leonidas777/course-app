module ApplicationHelper
  def trackable_partial(activity)
    activity.trackable_type.underscore
  end
end
