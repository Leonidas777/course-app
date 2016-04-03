class CreateReceivedHomeworkUser < ActiveRecord::Migration
  def change
    create_table :received_homework_users do |t|
      t.integer :user_id
    t.integer :homework_id

    t.timestamps
    end

    add_index :received_homework_users, [:user_id, :homework_id], unique: true
  end
end
