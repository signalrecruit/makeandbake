class AddSizeToSearchModel < ActiveRecord::Migration
  def change
  	add_column :searches, :size, :string
  end
end
