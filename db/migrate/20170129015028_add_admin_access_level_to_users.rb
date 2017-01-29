class AddAdminAccessLevelToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :admin_access_level, :integer, default: 0
  end
end
