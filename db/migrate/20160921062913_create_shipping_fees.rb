class CreateShippingFees < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_fees do |t|
    	t.integer :shipping_charge, precision: 12, scale: 3
		t.integer :weight_category_id, index: true, index: true
    	t.integer :country_id, index: true, index: true

      t.timestamps
    end
  end
end
