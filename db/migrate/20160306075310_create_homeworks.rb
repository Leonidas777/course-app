class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :lesson_id
      t.integer :user_id
      t.string  :hw_text

      t.timestamps
    end
  end
end
