class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many   :homeworks

  scope :all_by_position, -> { order(position: :asc) }
  scope :only_visible_by_position, -> { all_by_position.where(visible: true) }

  validates :title, presence: true, length: { maximum: 300 }
  validates :description, presence: true
  validates :summary, presence: true
  validates :homework, presence: true

  mount_uploader :picture, ProjectPictureUploader

  def show!
    update!(visible: true)
  end

  def hide!
    update!(visible: false)
  end
end
