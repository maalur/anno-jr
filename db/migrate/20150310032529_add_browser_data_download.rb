class AddBrowserDataDownload < ActiveRecord::Migration
  def change
  	add_column :browsers, :data_download, :text
  end
end
