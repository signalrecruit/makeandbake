class AddImageColumnsToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :imageone, :string
  	add_column :products, :imagetwo, :string
  	add_column :products, :imagethree, :string
  	add_column :products, :imagefour, :string
  end
end
