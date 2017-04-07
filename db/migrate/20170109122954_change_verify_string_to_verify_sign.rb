class ChangeVerifyStringToVerifySign < ActiveRecord::Migration[5.0]
  def change
    rename_column :paypal_transactions, :verify_string, :verify_sign
  end
end
