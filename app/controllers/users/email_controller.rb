class Users::EmailController < Users::BaseController  
  
  def new
  end

  def create
    if current_user.update(user_params)
      redirect_to course_subscriptions_path(course)
    else
      flash[:email_error] = 'Creating email failed.'
      render :form
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method: course

  def user_params
    params.require(:user).permit(:email)
  end
end
