class AddSharedKeyToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :shared_key, :string
  end
end
