class AddOrderIdToCcaTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :cca_transactions, :order_id, :string
    add_column :cca_transactions, :tracking_id, :string
  end
end
