class AddIndexToCourseUsers < ActiveRecord::Migration
  def change
    add_index :course_users, :course_id, unique: true
  end
end
