class AddBlockFlagToCourseUsers < ActiveRecord::Migration
  def change
    add_column :course_users, :block, :boolean, default: false
  end
end
