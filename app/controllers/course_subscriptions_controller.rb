class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    return course.participants << current_user unless current_user.blocked_in?(course)
    redirect_for_blocked_user("A blocked user can't subscribe on course.")
  end

  def destroy
    return course.course_users.where(user_id: current_user.id).first.destroy unless current_user.blocked_in?(course)
    redirect_for_blocked_user("A blocked user can't unsubscribe on course.")
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def redirect_for_blocked_user(message)
    flesh[:blocked_user_error] = message
    flash.keep(:blocked_user_error)
    render js: "window.location = #{courses_path.to_json}"
  end

  helper_method :course
end
