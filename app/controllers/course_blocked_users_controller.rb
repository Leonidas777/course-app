class CourseBlockedUsersController < ApplicationController
  def create
    course.blocked_users << user
    course.course_users.where(user_id: user.id).first.destroy
  end

  def destroy
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  helper_method :user
end
