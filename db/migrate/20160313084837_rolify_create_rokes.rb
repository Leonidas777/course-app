class RolifyCreateRokes < ActiveRecord::Migration
  def change
    create_table(:rokes) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_rokes, :id => false) do |t|
      t.references :user
      t.references :roke
    end

    add_index(:rokes, :name)
    add_index(:rokes, [ :name, :resource_type, :resource_id ])
    add_index(:users_rokes, [ :user_id, :roke_id ])
  end
end
