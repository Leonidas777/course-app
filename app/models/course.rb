class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_users
  has_many :participants, through: :course_users, source: :user
  has_many :lessons, foreign_key: :course_id

  scope :recent, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 20 }

  mount_uploader :picture, ProjectPictureUploader
end
