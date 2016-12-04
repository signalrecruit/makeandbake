class AddImageUrlToUserModel < ActiveRecord::Migration
  def change
  	add_column :users, :twitter_image, :string
  end
end
