class AddIndexToCourseBlockedUsers < ActiveRecord::Migration
  def change
    add_index :course_blocked_users, :course_id, unique: true
  end
end
