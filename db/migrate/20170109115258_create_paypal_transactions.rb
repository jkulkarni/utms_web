class CreatePaypalTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :paypal_transactions do |t|
      t.string :order_id
      t.float :mc_gross
      t.string :protection_eligibility
      t.string :address_status
      t.string :item_number1
      t.string :payer_id
      t.float :tax
      t.string :address_street
      t.string :payment_date
      t.string :payment_status
      t.string :charset
      t.string :address_zip
      t.float :mc_shipping
      t.float :mc_handling
      t.string :first_name
      t.string :address_country_code
      t.string :address_name
      t.string :notify_version
      t.string :custom
      t.string :payer_status
      t.string :address_country
      t.integer :num_cart_item
      t.float :mc_handling
      t.string :address_city
      t.string :verify_string
      t.string :payer_email
      t.float :mc_shipping
      t.float :tax1
      t.string :txn_id
      t.string :payment_type
      t.string :payer_business_name
      t.string :last_name
      t.string :address_state
      t.string :item_name1
      t.string :receiver_email
      t.integer :quantity1
      t.string :pending_reason
      t.string :txn_type
      t.float :mc_gross_1
      t.string :mc_currency
      t.string :residence_country
      t.integer :test_ipn
      t.string :transaction_subject
      t.float :payment_gross
      t.string :ipn_track_id

      t.timestamps
    end
  end
end
