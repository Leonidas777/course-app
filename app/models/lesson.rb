class Lesson < ActiveRecord::Base
  belongs_to :course

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :summary, length: { maximum: 1000 }
  validates :homework, presence: true, length: { maximum: 1000 }

  mount_uploader :picture, ProjectPictureUploader

  def is_visible?
    self.visible?
  end
end
