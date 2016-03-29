class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :course_id
      t.string  :title
      t.integer :position
      t.string  :description
      t.string  :picture
      t.string  :summary
      t.string  :homework

      t.timestamps
    end
    add_index :lessons, :course_id, unique: true 
  end
end
