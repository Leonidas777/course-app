class RemoveIndexFromLessons < ActiveRecord::Migration
  def change
    remove_index :lessons, :course_id
  end
end
