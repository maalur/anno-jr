class RemoveFetcherDataFromTrack < ActiveRecord::Migration
  def change
  	change_table :tracks do |t|
  	t.remove 	:iconCls, :curator_name, :curator_email, :inst_name,
  						:inst_url, :inst_logo, :synd_title, :synd_copyright,
  						:synd_license, :synd_version, :synd_details
    end
  end
end
