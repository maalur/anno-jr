class AddBrowserInfo < ActiveRecord::Migration
  def change
  	add_column :browsers, :description, :text
  	add_column :browsers, :citation, :string
  end
end
