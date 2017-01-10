class AddColumnsForSenderDetailsToOrderModel < ActiveRecord::Migration
  def change
  	add_column :orders, :sender_name, :string
  	add_column :orders, :sender_address, :string
  	add_column :orders, :sender_email, :string
  	add_column :orders, :sender_phonenumber, :string
  end
end
