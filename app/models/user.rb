class User < ActiveRecord::Base
  rolify role_cname: 'Roke'
  include Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_one  :profile, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :authored_courses, class_name: 'Course', foreign_key: :user_id, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :participated_courses, through: :course_users, source: :course

  has_many :homeworks, dependent: :destroy
  has_many :received_homework_users, dependent: :destroy
  has_many :received_homeworks, through: :received_homework_users, source: :homework

  has_many :activities_for_me,  class_name: 'Activity', foreign_key: :recipient_id
  has_many :activities_from_me, class_name: 'Activity', foreign_key: :owner_id

  before_save  :ensure_authentication_token

  after_create do
    create_user_profile
    set_default_role
  end

  accepts_nested_attributes_for :profile, allow_destroy: true

  delegate :first_name, :last_name, :photo, to: :profile, allow_nil: true

  def participate_in?(course_id)
    course_users.exists?(course_id: course_id)
  end

  def email?
    email.present?
  end

  def blocked_in?(course)
    course_user_rec = CourseUser.all.where(course_id: course.id, user_id: id).first
    course_user_rec.block if course_user_rec.present?
  end

  def author?(course)
    courses.find_by_id(course.id).present?
  end

  def self.all_unblocked_participants(course)
    User.joins(:course_users).where(course_users: { course_id: course.id, block: false }).includes(:profile)
  end

  private

  def create_user_profile
    return if profile.present?
    build_profile
    profile.save(validates: false)
  end

  def ensure_authentication_token
    self.authentication_token = generate_authentication_token if authentication_token.blank?
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end

  def set_default_role
    add_role :user
  end
end
