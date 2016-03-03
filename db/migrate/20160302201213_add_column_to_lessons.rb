class AddColumnToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :visible, :boolean, default: true
  end
end
