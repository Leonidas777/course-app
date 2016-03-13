class User < ActiveRecord::Base
  rolify role_cname: 'Roke'
  include Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_one  :profile, dependent: :destroy
  has_many :courses
  has_many :authored_courses, class_name: 'Course', foreign_key: :user_id, dependent: :destroy
  has_many :social_profiles
  has_many :course_users
  has_many :participated_courses, through: :course_users, source: :course

  has_many :homeworks
  has_many :blocked_users_courses, through: :course_blocked_user, source: :course

  after_create :create_user_profile
  accepts_nested_attributes_for :profile, allow_destroy: true

  delegate :first_name, :last_name, :photo, to: :profile, allow_nil: true

  def participate_in?(course_id)
    course_users.exists?(course_id: course_id)
  end

  private

  def create_user_profile
    build_profile
    profile.save(validates: false)
  end
end
