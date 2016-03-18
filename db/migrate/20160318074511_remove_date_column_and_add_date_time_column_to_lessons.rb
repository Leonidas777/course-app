class RemoveDateColumnAndAddDateTimeColumnToLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :date, :date
    add_column :lessons, :meeting_datetime, :datetime, null: true
  end
end
