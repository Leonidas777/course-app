class Users::EmailController < Users::BaseController
  
  # def new
  # end

  # def create
  #   current_user.update(user_params)
  #   if current_user.save(validate: false)
  #     redirect_to course_subscriptions_path(course_id: params[:course_id])
  #     map.resources :groups, :member => { :invite => :get }
  #   else
  #     render :email_saving_error
  #   end
  # end

  # private

  # def user_params
  #   params.delete(:password)
  #   params.delete(:password_confirmation)
  #   params.require(:user).permit(:email)
  # end
end
