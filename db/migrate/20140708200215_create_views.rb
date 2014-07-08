class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :linker_id
      t.integer :linked_id

      t.timestamps
    end
    add_index :views, :linker_id
    add_index :views, :linked_id
    add_index :views, [:linker_id, :linked_id], unique: true
  end
end
