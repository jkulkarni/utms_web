class AddPaymentGatewayToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :payment_gateway, :string
  end
end
