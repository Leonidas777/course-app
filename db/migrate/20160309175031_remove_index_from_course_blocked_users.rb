class RemoveIndexFromCourseBlockedUsers < ActiveRecord::Migration
  def change
    add_index :course_blocked_users, [:user_id, :course_id], unique: true
  end
end
