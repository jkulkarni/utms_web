class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :transcript_application_id, index: true, index: true
      t.integer :order_id, index: true, index: true
      # remove subtotal

      t.timestamps
    end
  end
end