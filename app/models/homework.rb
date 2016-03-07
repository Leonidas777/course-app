class Homework < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  validates :hw_text, presence: true, length: { maximum: 1000 }
end
