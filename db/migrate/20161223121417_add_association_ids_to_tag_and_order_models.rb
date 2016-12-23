class AddAssociationIdsToTagAndOrderModels < ActiveRecord::Migration
  def change
  	add_reference :tags, :order, foreign_key: true
  	add_reference :orders, :tag, foreign_key: true
  end
end
