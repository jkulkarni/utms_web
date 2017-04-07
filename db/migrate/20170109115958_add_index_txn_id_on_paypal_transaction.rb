class AddIndexTxnIdOnPaypalTransaction < ActiveRecord::Migration[5.0]
  def change
    add_index :paypal_transactions, :txn_id, unique: true
  end
end
