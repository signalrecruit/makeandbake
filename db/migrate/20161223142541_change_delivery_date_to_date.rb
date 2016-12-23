class ChangeDeliveryDateToDate < ActiveRecord::Migration
  def change
  	remove_column :orders, :delivery_date, :datetime
  	add_column :orders, :delivery_date, :date
  end
end
