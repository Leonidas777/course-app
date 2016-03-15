class Api::V1::AuthTokensController < ActionController::Base
  def create
    if params[:email].present? && params[:password].present?
      auth_token = authenticate_by_email
    elsif params[:service_name].present?
      auth_token = authenticate_through_social_network
    end

    render json: { success: true, auth_token: auth_token }, status: 200 if auth_token.present?
    raise NotAuthorized
  end

  private

  def authenticate_by_email
    user = User.find_by_email(params[:email])
    user.authentication_token if user.present? && user.valid_password?(params[:password])
  end

  def authenticate_through_social_network
    if params[:service_name] == 'facebook'
      return if params[:access_token].empty?
      profile = facebook.get_object('me')

      social_profile = SocialProfile.find_by(uid: profile['id'], service_name: 'facebook')
      authentication_token_by_social_profile(social_profile)
    elsif params[:service_name] == 'twitter'
      return if params[:access_token].empty? || params[:secret_key].empty?
      social_profile = SocialProfile.find_by(uid: twitter.user['id'], service_name: 'twitter')
      authentication_token_by_social_profile(social_profile)
    end
  end

  def authentication_token_by_social_profile(social_profile)
    if social_profile.present?
      user = social_profile.user
      user.authentication_token if user.present?
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(params[:access_token])
  end

  def twitter
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = params[:access_token]
      config.access_token_secret = params[:secret_key]
    end
  end
end
