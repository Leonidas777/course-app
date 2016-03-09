class RemoveIndexFromCourseUser < ActiveRecord::Migration
  def change
    remove_index :course_blocked_users, [:user_id, :course_id]
  end
end
