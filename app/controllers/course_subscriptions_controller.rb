class CourseSubscriptionsController < ApplicationController
  before_action :authenticate_user!

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

  def user_params
    params.require(:user).permit(:email)
  end

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
