class CreateCourseBlockedUsers < ActiveRecord::Migration
  def change
    create_table :course_blocked_users do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end

    add_index :course_blocked_users, [:user_id, :course_id], unique: true
  end
end
