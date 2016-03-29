class RenameColumnToHomeworks < ActiveRecord::Migration
  def change
    rename_column :homeworks, :hw_text, :content
  end
end
