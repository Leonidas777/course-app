class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :current_user_is_blocked

  def create
    unless current_user.email.present?
      return render :open_email_form if params[:user].nil? || params[:user][:email].nil?

      current_user.update(user_params)
      return render :email_saving_error unless current_user.save(validate: false)
    end

    course.participants << current_user
  end

  def destroy
    course.course_users.where(user_id: current_user.id).first.destroy
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def current_user_is_blocked
    render :baned_user if current_user.blocked_in?(course)
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
