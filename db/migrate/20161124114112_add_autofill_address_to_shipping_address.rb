class AddAutofillAddressToShippingAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :shipping_addresses, :autofill_address, :string
  end
end
