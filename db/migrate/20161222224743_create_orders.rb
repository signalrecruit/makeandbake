class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :description
      t.string :order_type
      t.decimal :min_price
      t.decimal :max_price
      t.string :size
      t.datetime :delivery_date
      t.string :recipient_address
      t.string :recipient_name
      t.string :recipient_phonenumber
      t.string :recipient_email
      t.string :sample_picture
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
