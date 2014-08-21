class AddGenomeToBrowser < ActiveRecord::Migration
  def change
  	add_column :browsers, :genome, :string
  end
end
