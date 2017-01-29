class AddColumnToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :seller_id, :integer, default: nil
  end
end
