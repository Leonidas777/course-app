class ParticipantsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def index
    @users = course.participants.where.not(id: course.blocked_users).includes(:profile)
  end

  def destroy
    CourseBlockedUser.create(course_id: params['course_id'], user_id: params['id']).save!

    redirect_to course_participants_path
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def blocked_user?
    course.blocked_users.where(id: current_user).exists?
  end

  helper_method :course, :blocked_user?
end
