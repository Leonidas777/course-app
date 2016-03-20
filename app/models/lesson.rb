class Lesson < ActiveRecord::Base
  include AASM
  require 'date'
  NOTIF_DAYS_BEFORE = 3

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

  def meeting_date
    return meeting_datetime.strftime('%I:%M%p on %B %d, %Y') if meeting_datetime.present?
    'undefined'
  end

  def creating_date
    return created_at.strftime('%I:%M%p on %B %d, %Y, %I:%M%p') if created_at.present?
    'undefined'
  end

  aasm column: :state do
    state :pending, initial: true
    state :loading
    state :loaded

    event :material_loading do
      transitions to: :loading
    end

    event :material_loaded, after_commit: :notify_participants do 
      transitions from: :loading, to: :loaded
    end
  end

  def notify_participants
    mail_to_participants_now
    remind_participants_later
  end

  def mail_to_participants_now
    ScheduleLoadedMaterialNotificationWorker.perform_async(id)
  end

  def remind_participants_later
    notification_time = meeting_datetime - NOTIF_DAYS_BEFORE.minute
    if DateTime.now < notification_time
      ScheduleRemindAboutLessonNotificationWorker.perform_async(id, notification_time)
    end
  end  
end
