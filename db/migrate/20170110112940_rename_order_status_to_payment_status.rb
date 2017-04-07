class RenameOrderStatusToPaymentStatus < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :status, :payment_status
  end
end
