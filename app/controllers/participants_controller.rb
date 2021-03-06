class ParticipantsController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]

  def index
    @users = User.all_unblocked_participants(course)
  end

  def destroy
    course.expel_user(user)

    redirect_to course_participants_path
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def blocked_user?
    course.blocked_users.where(id: current_user).exists?
  end
  helper_method :blocked_user?
end
