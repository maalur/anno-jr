class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
    	t.integer :user_id
    	t.string :name
    	t.string :type
    	t.string :path
    	t.string :data
    	t.string :iconCls
    	t.string :curator_name
    	t.string :curator_email
    	t.string :inst_name
    	t.string :inst_url
    	t.string :inst_logo
      t.string :synd_title
      t.string :synd_copyright
      t.string :synd_license
      t.date :synd_version
      t.string :synd_details      

      t.timestamps
    end
    add_index :tracks, [:user_id, :created_at]
  end
end
