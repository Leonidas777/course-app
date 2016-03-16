class CourseBlockedUsersController < ApplicationController
  def create
    course_user_rec = CourseUser.all.where(course_id: params['course_id'], user_id: params['user_id']).first
    course_user_rec.update!(block: true) if course_user_rec.present?
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
