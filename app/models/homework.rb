class Homework < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :lesson

  validates :content, presence: true

  after_commit :send_homework_for_checking

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions to: :approved, after_commit: :homework_approving
    end

    event :reject do
      transitions from: :approved, to: :rejected, after_commit: :homework_rejecting
    end
  end

  private

  def homework_approving    
    NotificationsMailer.homework_approving(self, user).deliver_now
  end

  def homework_rejecting
    NotificationsMailer.homework_rejecting(self, user).deliver_now
  end

  def send_homework_for_checking
    lesson.course.user.received_homeworks << self
  end
end
