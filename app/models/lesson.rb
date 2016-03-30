class Lesson < ActiveRecord::Base
  include AASM

  NOTIF_DAYS_BEFORE = 1

  belongs_to :course
  has_many   :homeworks
  has_many   :activities, as: :trackable

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

  def meeting_date
    return meeting_datetime.strftime('at %I:%M%p, %B %d, %Y') if meeting_datetime.present?
    'undefined'
  end

  def creating_date
    return created_at.strftime('at %I:%M%p, %B %d, %Y') if created_at.present?
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
    return unless meeting_datetime.present?
    notification_time = meeting_datetime - NOTIF_DAYS_BEFORE.day
    if Time.zone.now <= notification_time
      ScheduleRemindAboutLessonNotificationWorker.perform_async(id, notification_time)
    end
  end
end
