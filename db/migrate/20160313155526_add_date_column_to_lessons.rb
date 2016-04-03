class AddDateColumnToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :date, :date, null: true  
  end
end
