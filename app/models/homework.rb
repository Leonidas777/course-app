class Homework < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :lesson

  validates :hw_text, presence: true, length: { maximum: 1000 }

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions to: :approved
    end

    event :reject do
      transitions from: :approved, to: :rejected
    end
  end
end
