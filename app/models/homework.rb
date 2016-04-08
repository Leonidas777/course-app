class Homework < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :lesson

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }

  after_create :send_homework_for_checking
  after_create :create_homework_pending_activity

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve, after_commit: :homework_approving do
      transitions to: :approved
    end

    event :reject, after_commit: :homework_rejecting do
      transitions to: :rejected
    end
  end

  private

  def homework_approving
    create_homework_approved_activity
    ApprovedHomeworkNotificationWorker.perform_async(id)
  end

  def homework_rejecting
    create_homework_rejected_activity
    RejectedHomeworkNotificationWorker.perform_async(id)
  end

  def send_homework_for_checking
    lesson.course.user.received_homeworks << self
  end

  def create_homework_approved_activity
    create_activity(Activity::KIND_HOMEWORK_APPROVED, 'The homework was approved.', lesson.course.user.id)
  end

  def create_homework_rejected_activity
    create_activity(Activity::KIND_HOMEWORK_REJECTED, 'The homework was rejected.', lesson.course.user.id)
  end

  def create_homework_pending_activity
    create_activity(Activity::KIND_HOMEWORK_PENDING, 'The homework is pending.')
  end

  def create_activity(kind, message, owner_id=user_id, recipient_id=user_id, trackable=self)
    Activity.create!(
      owner_id: owner_id,
      recipient_id: recipient_id,
      trackable: trackable,
      kind: kind,
      message: message
    )
  end
end
