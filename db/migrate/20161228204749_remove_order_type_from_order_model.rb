class RemoveOrderTypeFromOrderModel < ActiveRecord::Migration
  def change
  	remove_column :orders, :order_type, :string
  	remove_column :orders, :tag_id, :integer
  	remove_column :tags, :order_id, :integer
  end
end
