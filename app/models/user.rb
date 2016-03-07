class User < ActiveRecord::Base
  include Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_one  :profile
  has_many :authored_courses, class_name: 'Course', foreign_key: :user_id, dependent: :destroy
  has_many :social_profiles
  has_many :course_users
  has_many :participated_courses, through: :course_users, source: :course

  has_many :homeworks

  accepts_nested_attributes_for :profile

  delegate :first_name, :last_name, :photo, to: :profile, allow_nil: true

  def participate_in?(course)
    course_users.exists?(course_id: course.id)
  end
end
