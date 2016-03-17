class Lesson < ActiveRecord::Base
  include AASM

  PER_PAGE = 6
  belongs_to :course
  has_many   :homeworks

  scope :desc_order, -> { order(created_at: :desc) }
  scope :asc_order, -> { order(created_at: :asc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :summary, length: { maximum: 1000 }
  validates :homework, presence: true, length: { maximum: 1000 }

  after_create :send_notifications

  mount_uploader :picture, ProjectPictureUploader

  def self.visible?
    visible?
  end

  def self.one_page(page, per_page, visible=false)
    return where(visible: true).page(page).per(per_page || PER_PAGE) if visible
    page(page).per(per_page || PER_PAGE)
  end

  def meeting_date
    return date.strftime('on %B %d, %Y') if date.present?
    'undefined'
  end

  def creating_date
    return created_at.strftime('on %B %d, %Y, %I:%M%p') if created_at.present?
    'undefined'
  end

  aasm column: :state do
    state :pending, initial: true
    state :loading
    state :loaded

    event :material_loading do
      transitions to: :loading
    end

    event :material_loaded do 
      transitions from: :loading, to: :loaded, after_commit: :mail_to_participants
    end
  end

  def mail_to_participants
    course.participants.each do |user|
      NotificationsMailer.loaded_material(self, user).deliver_now
    end
  end

  def send_notifications
    material_loading
    material_loaded!
  end
end
