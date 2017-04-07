class AddOrderStatusToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :order_status, :string
  end
end
