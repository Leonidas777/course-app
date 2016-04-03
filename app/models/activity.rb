class Activity < ActiveRecord::Base
  KIND_LESSON_LOADED = 0
  KIND_HOMEWORK_PENDING = 1
  KIND_HOMEWORK_APPROVED = 2
  KIND_HOMEWORK_REJECTED = 3

  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :owner,     class_name: 'User', foreign_key: :owner_id
  belongs_to :trackable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }
end
