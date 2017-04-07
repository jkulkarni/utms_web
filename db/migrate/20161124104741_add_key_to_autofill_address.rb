class AddKeyToAutofillAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :autofill_addresses, :key, :string
  end
end
