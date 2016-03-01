class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_users
  has_many :participants, through: :course_users, source: :user

  scope :recent, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 20 }

  mount_uploader :picture, ProjectPictureUploader
end
