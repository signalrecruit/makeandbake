class AddColumnsToDeviseModel < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :username, :string
  	add_column :users, :age, :integer, default: 0
  	add_column :users, :seller, :boolean, default: false
  	add_column :users, :admin, :boolean, default: false
  	add_column :users, :sex, :string, default: "female"
  end
end
