class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
    	t.string :coupon_code
    	t.integer :applicable_times
    	t.integer :applied_times
    	t.integer :discount
    	t.boolean :applicable, :default => true
  		t.date :coupon_expires_on

      t.timestamps
    end
  end
end
