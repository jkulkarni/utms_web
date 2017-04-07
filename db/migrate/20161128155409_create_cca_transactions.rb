class CreateCcaTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :cca_transactions do |t|
      t.string :bank_ref_no
      t.string :order_status
      t.string :failure_message
      t.string :payment_mode
      t.string :card_name
      t.string :status_code
      t.string :status_message
      t.string :currency
      t.integer :amount
      t.string :billing_name
      t.string :billing_address
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip
      t.string :billing_country
      t.string :billing_tel
      t.string :billing_email
      t.string :delivery_name
      t.string :delivery_address
      t.string :delivery_city
      t.string :delivery_state
      t.string :delivery_zip
      t.string :delivery_zip
      t.string :delivery_country
      t.string :delivery_tel
      t.string :merchant_param1
      t.string :merchant_param2
      t.string :merchant_param3
      t.string :merchant_param4
      t.string :merchant_param5
      t.string :vault
      t.string :offer_type
      t.string :offer_code
      t.integer :discount_value
      t.integer :mer_amount
      t.string :eci_value
      t.string :retry
      t.string :response_code
      t.string :billing_notes
      t.string :trans_date

      t.timestamps
    end
  end
end
