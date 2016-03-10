class RemoveCourseBlockedUser < ActiveRecord::Migration
  def change
    drop_table :course_blocked_users
  end
end
