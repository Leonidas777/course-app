class Lesson < ActiveRecord::Base
  PER_PAGE = 6
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

  def self.one_page(page, per_page, visible=false)
    return where(visible: true).page(page).per(per_page || PER_PAGE) if visible
    page(page).per(per_page || PER_PAGE)
  end
end
