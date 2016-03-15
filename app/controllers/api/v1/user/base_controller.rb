class Api::V1::User::BaseController < Api::V1::BaseController
  before_action :authenticate_user!

  private

  def authenticate_user!
    user = User.find_by(authentication_token: params[:auth_token])
    return sign_in user, store: false if user.present?
    raise NotAuthorized
  end
end
