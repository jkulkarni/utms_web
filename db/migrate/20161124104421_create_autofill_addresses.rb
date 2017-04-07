class CreateAutofillAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :autofill_addresses do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state_province_region
      t.string :zip_or_postal_code
      t.string :phone
      t.integer :country_id

      t.timestamps
    end
  end
end
