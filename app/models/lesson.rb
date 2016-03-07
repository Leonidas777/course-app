class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many   :homeworks

  scope :desc_order, -> { order(created_at: :desc) }
  scope :asc_order, -> { order(created_at: :asc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :summary, length: { maximum: 1000 }
  validates :homework, presence: true, length: { maximum: 1000 }

  mount_uploader :picture, ProjectPictureUploader

  def self.visible?
    visible?
  end
end
