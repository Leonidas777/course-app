class Course < ActiveRecord::Base
  belongs_to :user
  has_many   :course_users
  has_many   :course_blocked_users
  has_many   :participants, through: :course_users, source: :user
  has_many   :blocked_users, through: :course_blocked_users, source: :user
  has_many   :lessons, foreign_key: :course_id, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 40 }

  mount_uploader :picture, ProjectPictureUploader

  def creating_date
    return created_at.strftime('on %B %d, %Y, %I:%M%p') if created_at.present?
    'undefined'
  end

  def expel_user(user)
    course_user_rec = CourseUser.all.where(course_id: id, user_id: user.id).first
    course_user_rec.block = true if course_user_rec.present?
  end
end
