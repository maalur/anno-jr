class CreateBrowsers < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :browsers, [:user_id, :created_at]
  end
end
