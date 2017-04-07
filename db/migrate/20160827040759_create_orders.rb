class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total, precision: 12, scale: 3
      t.integer :order_status_id, index: true, index: true
      t.integer :user_id, index: true, index: true
      t.string :currency, :default => "INR"
      t.string :order_id
      t.datetime :purchased_at
	    t.boolean :coupon_applied, :default => false
      
      t.timestamps
    end
  end
end