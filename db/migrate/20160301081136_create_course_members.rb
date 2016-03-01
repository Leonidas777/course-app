class CreateCourseMembers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end

    add_index :course_users, [:user_id, :user_id], unique: true
  end
end
