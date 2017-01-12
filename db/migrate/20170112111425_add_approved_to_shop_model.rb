class AddApprovedToShopModel < ActiveRecord::Migration
  def change
  	add_column :shops, :approved, :boolean, default: false
  end
end
