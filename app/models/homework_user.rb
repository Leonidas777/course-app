class HomeworkUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :homework

  validates :homework_id, uniqueness: { scope: :user_id }
end
