class AddSizeColumnToProductTable < ActiveRecord::Migration
  def change
  	add_column :products, :size, :string, default: "not specified"
  end
end
