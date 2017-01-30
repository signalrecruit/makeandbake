class AddImageToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :sample_image, :string
  end
end
