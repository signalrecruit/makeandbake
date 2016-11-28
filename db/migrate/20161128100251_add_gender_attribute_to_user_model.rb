class AddGenderAttributeToUserModel < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :string, default: "female"
  end
end
