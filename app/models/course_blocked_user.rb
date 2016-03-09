class CourseBlockedUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, uniqueness: { scope: :course_id, message: 'This RECORD already exists in the CourseBlockedUser table!' }
end
