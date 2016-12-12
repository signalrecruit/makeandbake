class RemoveEmailAndPhonenumberFromShopModel < ActiveRecord::Migration
  def change
  	remove_column :shops, :email, :string
  	remove_column :shops, :phonenumber, :string
  end
end
